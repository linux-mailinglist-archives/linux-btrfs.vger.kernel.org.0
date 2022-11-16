Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3367D62CD46
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Nov 2022 23:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbiKPWA5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Nov 2022 17:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKPWA4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Nov 2022 17:00:56 -0500
X-Greylist: delayed 1795 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Nov 2022 14:00:54 PST
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BC34385D
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Nov 2022 14:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=buNZNTyw64cqYMlD9qTjxpOJv6jJm2RBfN6awvTNne0=; b=Rg/nHM4Y7bjdKKFaabdtKZVna4
        ZJy9JJO/gcyqIblYZaAEBVi33I+P3Ey1h4QlaJe+hMn9emCJvBXUSxF4eKnacBINFHLFJf22ihB3u
        0YCRllCI3CIgvQN8gDT9dmqRkw5Ijof/v4hc25YWmgocx8duhnzETIRgx7oktby1Tp69bavYk8Gd3
        GEG3SjpPsaJT3G71UeEpB8wCFz17iZRkY219hvqL1FwzkaH6UrNtFi0dyON62MqeDpPWDfz4bx89i
        /lvR+7zL/fw9gc7vSQcYM9KmEO1RuxDtLfPMIXucqELbsgTMGsV47FjQ45XG+7oH3x81Z9XgV89+R
        V217s2vg==;
Received: from [177.102.6.147] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ovPzk-0022VS-6H; Wed, 16 Nov 2022 22:30:56 +0100
Message-ID: <0878ac61-ce4b-f9a8-96dd-fb4cec0d711e@igalia.com>
Date:   Wed, 16 Nov 2022 18:30:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: About duplicate fsid images in different devices
Content-Language: en-US
To:     Torstein Eide <torsteine@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAL5DHTH7MRuq1d+CgvdQz58gnxaTSO-rbx7ha=C_r4Hf-T8LjQ@mail.gmail.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CAL5DHTH7MRuq1d+CgvdQz58gnxaTSO-rbx7ha=C_r4Hf-T8LjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16/11/2022 16:04, Torstein Eide wrote:
> Hi Guilherme
> ## Have you tried changing volumes instead of the partition?
> https://btrfs.readthedocs.io/en/latest/btrfs-subvolume.html
> <https://btrfs.readthedocs.io/en/latest/btrfs-subvolume.html>
> 
> ## Given that  SteamOS does not change much between updates. 
> Maybe look in to union Filesystem, like docker uses:
> https://martinheinz.dev/blog/44 <https://martinheinz.dev/blog/44>
> https://gdevillele.github.io/engine/userguide/storagedriver/btrfs-driver/ <https://gdevillele.github.io/engine/userguide/storagedriver/btrfs-driver/>
> 
> ## Alternativ 2 The use of snapshots of the OS partition/subvolume, like
> snapper:
> https://btrfs.readthedocs.io/en/latest/btrfs-subvolume.html#subvolume-and-snapshot <https://btrfs.readthedocs.io/en/latest/btrfs-subvolume.html#subvolume-and-snapshot>
> https://wiki.archlinux.org/title/snapper
> <https://wiki.archlinux.org/title/snapper>
> 
> 
> -- 
> Torstein Eide
> Torsteine@gmail.com <mailto:Torsteine@gmail.com>

Thank you Torstein! I'm not sure snapshot or Union filesystem approaches
would help - we just want a RO fs and be able to mount any of two
identical partitions (with the same fs/fsid) on btrfs. It doesn't work
in btrfs but it's fine on ext4. We could try improving the code with a
mount option, but this email to collect opinions if that would harm some
fundamental principle in btrfs and, indeed, would be unacceptable.

Cheers,


Guilherme

