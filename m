Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7EF7BD3F6
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 09:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345239AbjJIHAj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 03:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345027AbjJIHAh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 03:00:37 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27917A3
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Oct 2023 00:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kBruRMAEPXQIV8A3omeL6CWg8fY/HAUa5ZmzKMxmBnI=; b=fvzP3YeFjAYmv94WUfSzjhnYqZ
        T9gu0mHKD8Irxr/ARMsBFsyztowlCW62jB0y7s9bRPy+/lRq41MUbwAxC4PJGkrtRuif22KOyP4yg
        2VM4JrDshodnPomil2RehzcSbo36CansngOOAGbOXkSR3qlGE/tSttU4jkB7NS5Z3qbaN4WarzcbZ
        tCNXGDoGOBlS/9ODKwCUuMCKtee216KcznbGsJ9B//nyg30oyFf6hXpmV73LU+dXjoMJD4x6Di7nH
        +FmccNsuqWOBaN3KHnHlYg9U4Ex3jWq39EyhHLhIHQ7Rd5EAQLpHjeGjcBuTz8f6bfRoeFj3Yr4Vn
        L5vZ6SiA==;
Received: from cpe90-146-105-192.liwest.at ([90.146.105.192] helo=[192.168.178.99])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qpkFg-00FzKf-Gm; Mon, 09 Oct 2023 09:00:28 +0200
Message-ID: <dfb5e1fd-6eb3-b0bd-d5c6-0f5f9179eec4@igalia.com>
Date:   Mon, 9 Oct 2023 09:00:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 0/4] btrfs: sysfs and unsupported temp-fsid features for
 clones
To:     Anand Jain <anand.jain@oracle.com>, dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <cover.1696431315.git.anand.jain@oracle.com>
 <20231006150755.GH28758@twin.jikos.cz>
 <9cfb8122-4956-4032-b9ab-2eea8bb19415@oracle.com>
Content-Language: en-US
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <9cfb8122-4956-4032-b9ab-2eea8bb19415@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07/10/2023 12:30, Anand Jain wrote:
> [...]
>> How are we going to proceed with the patch from Guilherme?
> 
> The last step is to ensure that the temp-fsid feature is restricted
> with the temp-fsid superblock flag. Guilherme's patches
> (kernel, mkfs, and tune) already handle it but need a rebase.
> Can Guilherme send an RFC patch for feedback from others and
> copy suggested-by. Because, I haven't found a compelling reason
> for the restriction, except to improve the user experience.
> 
> His fstests patch will be accepted. And progressively we should
> add more coverage when the fstests configuration does not include
> the temp-fsid environment.
> 
> Lastly, in fact even for this patchset:
> 
>    Co-developed-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> Thanks, Anand
> 

Thanks Anand and David. The first thing I need to do, is to build
misc-next and test it if if works with my setup, to double-check Anand's
approach fits the use-case (it seems to, so far). Then, I guess we'll
need to see if there's a missing piece on that - in the other thread
Anand mentioned maybe the superblock flag would be useful after all, so
if that's necessary, I can send it of course.

Finally, this week I'm away from my regular system and cannot provide
the test results, next week I can do that for sure.

Thank you both for looping me in and for the details and clarifications!
Cheers,


Guilherme
