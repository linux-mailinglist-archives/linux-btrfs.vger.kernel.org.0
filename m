Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE554D0C07
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Mar 2022 00:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343866AbiCGXaa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 18:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343907AbiCGXa2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 18:30:28 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E96D53E2B
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 15:29:31 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id n19so7975311lfh.8
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 15:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S421D0RUkUOyjSwQJ/yUPGnSHeoOs6gCzEnrkGsDjTY=;
        b=QwEPOOjdYCCYQPHMIlsJiUOGMT2lHQjOnqy6HzWkiWz+HPmjg2LafqDGMDgsq7Lk3G
         WHIiHI8zZdjFC2dNT8+/dAgbNa9e/hye/j+ZuWWk9ppdqa9YHAnF0hAZIkeZHtvoQq3G
         9kn0ffKSkibvZr4FwNxbvqvC1PAX/Gz2kZZtgG2uwTVfT83OTj410KsfW9h2WD7c+OBx
         y789lsSB06sx030ZB/0T7WhpBDeQK69v5HGqbjEMYy86s2kvGVqUiq6eTuVUCWOAjLZq
         nJekKBN61fm5hBKFa9EfurrgSe1/9m90O0CZmbdtM6ZYAqpUWfLvy866RQki2Nu4jodV
         FUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S421D0RUkUOyjSwQJ/yUPGnSHeoOs6gCzEnrkGsDjTY=;
        b=I4P8aYdqmUce6LtVfRfThs0OIZs+ufrrioOjfgNbmv/9QX8J5TN06Tgp6dFKM8Q39o
         wZDIZBGNHbvATMYRy39CBibtet6zEo5EZBe+t5LXsuw7NjD7lpfKLr5dCiAuDbPwcQ4/
         WkseIlBOhWxxrIBQB5T1w/0F89OWLoIJVPbjyH0SNTTXMjvGjxw5GnBOxlf2SFY34CiA
         n2UyEjwNHPDXy2DkZV/BI14eBgnzlG14tZQdKwji65Gb9kWWSevqgSB93NK47n8IAZCY
         Dtea0oqdfrpZiNXVjOJarYAOGHVKc9wYGdJNSI50m2dhgmcjuP300kbDSqBqGrpD8dUx
         C5WA==
X-Gm-Message-State: AOAM532m3SbxqgyltFmqu2kk+ORV0OPdc/6K0j6GnXA5txUe0kCeH3Bb
        kNif8SDWf9yVE5MR1rplVZTVpBPPEbsgjrAiQQ2ZGA==
X-Google-Smtp-Source: ABdhPJzdGnkQzcQCg4FHfhnvYzPasdTL+StrH8bWOQga1ib3IXWJAzcSi/hebSyF52kwE0gvoP6GbfWORbFRVEZUfGo=
X-Received: by 2002:ac2:4315:0:b0:448:2bb9:f11d with SMTP id
 l21-20020ac24315000000b004482bb9f11dmr5835292lfh.212.1646695769602; Mon, 07
 Mar 2022 15:29:29 -0800 (PST)
MIME-Version: 1.0
References: <1cb1e7d9-51d0-4c2e-8cd1-6b02d045bcad@gmail.com>
In-Reply-To: <1cb1e7d9-51d0-4c2e-8cd1-6b02d045bcad@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 7 Mar 2022 16:29:13 -0700
Message-ID: <CAJCQCtTgVyWGXG6psu2d_4BuH+y0SBm3Zxqr44qzJB9Huh__0Q@mail.gmail.com>
Subject: Re: Recover btrfs partition after accidental reformat
To:     Emil <broetchenrackete@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 7, 2022 at 1:10 PM Emil <broetchenrackete@gmail.com> wrote:
>
> Hi,
>
> I did a boo boo and reformatted my btrfs partition with NTFS (used the wrong /dev/sdX). It was a single drive with standard options (metadata dup, data single) and it was the only partition of the drive.

You'll have damaged files most likely but there's some chance that
with DUP metadata the file system can self-repair its way out of this
mistake.

You could check out
https://raid.wiki.kernel.org/index.php/Irreversible_mdadm_failure_recovery#Simple_using_of_overlays
for guidance on how to use device-mapper to make the drive partition
read-only, and redirect any recovery attempts (writes) to a file so
that it's all reversible. Or take a chance and just apply the changes
to the partition directly... thought it could make things worse.

My thought is to start out with wiping the NTFS signature only, and
making a backup of it (optional, sorta boilerplate but it sounds like
you don't care about this NTFS file system anyway since it was a
mistake).

wipefs -b -t ntfs /dev/sdXY

Next, check status of superblocks before repairing them:

btrfs rescue super -v /dev/sdXY

If there are damaged superblocks it should give you a choice to repair
them from a good superblock. You can do that. Next, try to mount it.
If you're on overlay, just mount it normally and see what happens. If
not, you might go more conservative with

mount -o ro /dev/sdXY

I'm actually not fully sure that this prevents all writes. i.e. if
there's DUP metadata, and btrfs finds corruption with one copy, pretty
sure it tries to write fixups from a good copy. The ro is a VFS mount
option, and enforces no writes from user space, but the kernel code
can still write. I think. So it's a small risk.

I'd probably do this with a current stable or mainline kernel, i.e.
5.15+. This also allows you the option to use combinations of the
rescue= mount options along with ro, in case too much metadata is
damaged for normal mount, you can sometimes skip over the broken
parts. If you're lucky, you might just end up with only some corrupt
files. This will definitely produce a *lot* of btrfs kernel messages,
you will get around 1/2 dozen at least per 4KiB block damaged.

Good luck!


-- 
Chris Murphy
