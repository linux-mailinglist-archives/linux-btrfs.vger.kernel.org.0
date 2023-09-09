Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5438F7997DC
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Sep 2023 14:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345567AbjIIMQ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Sep 2023 08:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjIIMQ0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Sep 2023 08:16:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C687CCA
        for <linux-btrfs@vger.kernel.org>; Sat,  9 Sep 2023 05:16:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E30C433C7;
        Sat,  9 Sep 2023 12:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694261781;
        bh=6DnKJ7X3JMWXf4eNsq5GSHWmhj3gSzMCYvuEfHdMjEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cI7eCtojrhMtxV/4poR41ZoL0ed3uWJbObw3ORq+QtlBsnMWNYSLJOMOJazmWC2Jc
         2kpP2fZdKu6ODtpEWBow64UtomUE7hq2DaBRh7zgCUv+UPxVRFTWTAIFqFucBGenLI
         DQM3Flqx6Qfuj9eael56bHeIy29ISk0l4rIfpSgsAj0pWvBnAhTlUlxqAi0OjHdEPU
         ejljOit5sjrVngvkbFVJsvgR1XrVJr0N1BHZk4/2zs9Pf+9tEMe3jd7mXZbAd8YkVD
         lv2zeFcd+PkAazBa71MnRRnfPvkQnfSVFCVAzVuIbt8VhBi3ZtXG0KkalfYfpk0ANk
         0Kv08U8YtY+AQ==
Date:   Sat, 9 Sep 2023 13:16:15 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Ian Johnson <ian@ianjohnson.dev>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Possible readdir regression with BTRFS
Message-ID: <ZPxiDy1vZE5VIF93@debian0.Home>
References: <YR1P0S.NGASEG570GJ8@ianjohnson.dev>
 <ZPweR/773V2lmf0I@debian0.Home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPweR/773V2lmf0I@debian0.Home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 09, 2023 at 08:27:03AM +0100, Filipe Manana wrote:
> On Fri, Sep 08, 2023 at 09:07:10PM -0400, Ian Johnson wrote:
> > I was debugging an issue recently and came across what seems to be a
> > change in the behavior of opendir and readdir in Btrfs seemingly
> > starting with 9b378f6ad48cfa195ed868db9123c09ee7ec5ea2, specifically
> > when the contents of a directory are changed between the call to opendir
> > and the initial call to readdir. The following C program demonstrates
> > the behavior:
> > 
> > #import <dirent.h>
> > #import <stdio.h>
> > 
> > int main(void) {
> >  DIR *dir = opendir("test");
> > 
> >  FILE *file;
> >  file = fopen("test/1", "w");
> >  fwrite("1", 1, 1, file);
> >  fclose(file);
> > 
> >  file = fopen("test/2", "w");
> >  fwrite("2", 1, 1, file);
> >  fclose(file);
> > 
> >  /* rewinddir(dir); */
> > 
> >  struct dirent *entry;
> >  while ((entry = readdir(dir))) {
> >    printf("%s\n", entry->d_name);
> >  }
> >  closedir(dir);
> >  return 0;
> > }
> > 
> > Running this program with an initially empty test directory will print
> > entry 1 but not entry 2 on Btrfs, while on Ext4 it prints both entries.
> > 
> > Evidently this particular result is not an issue, as POSIX states:
> > 
> > > If a file is removed from or added to the directory after the most
> > > recent call to opendir() or rewinddir(), whether a subsequent call to
> > > readdir_r() returns an entry for that file is unspecified.
> 
> Yes, I can modify it to be more "logical" and don't return any new entry
> after the opendir() call. As it is now, it always returns only the first
> new entry after opendir().
> 
> > 
> > However, the same program with rewinddir uncommented above yields the
> > same behavior, seemingly in contradiction of POSIX:
> > 
> > > It [rewinddir] shall also cause the directory stream to refer to the
> > > current state of the corresponding directory, as a call to opendir()
> > > would have done.
> 
> That seems to make sense.
> I'll prepare a patch to ensure that behaviour and let you know when it's
> ready for you to test.

Here it is (I CC'ed you, but just to link the thread):

https://lore.kernel.org/linux-btrfs/cover.1694260751.git.fdmanana@suse.com/

> 
> Thanks.
> 
> > 
> > I know that the functions used here are part of the C library and not
> > the kernel, but given this seems to be a recent change, I wanted to
> > bring this up. I looked over the man pages for getdents and lseek and
> > didn't see any mention of guarantees (or lack thereof) in the face of
> > concurrent directory updates, so it's quite possible that this is within
> > the realm of expected/allowed behavior.
> > 
> > 
> > 
