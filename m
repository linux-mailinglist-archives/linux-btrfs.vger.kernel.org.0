Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A1953B184
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 04:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbiFBBuI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 21:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbiFBBuH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 21:50:07 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FBF21257D
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 18:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202112; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=X35WRI5N7OZ0VjJrTn2d2muO76eIyJ9ytJrganglfJ0=; b=F+JAppUwLN0LW1g3H7HBlcoUpI
        xE820/aki8Tt2mYUEtSdFQPzCbb5KerEoA0nIxrdg7vCLCI8E+UkIuoWY0BhfDB1YnLAWz21AXjdW
        NSUSQCpbpfP3kOo4z7h6SwCLofW1CjuwToOi/UG1r/rRLSiowIorTQDDGOW3XaHISzPOffHYELcrf
        +4nb4O5xL3IDWLf1XqcemVMyYl2QRPEG0cffEk3bMjaFbI1PmzsmCUH8WZf4dYH9B+LwEQe6HUMXr
        c773XGKIXSw3/KgXpRSuAVG0HXtZn476bHgOThDI6OFYNk7TQrDcpavMZXixwmuB0SvWx5cVCYfVN
        u5v+JXFw==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:48934 helo=[10.0.0.41])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1nwZyM-00040M-DZ; Thu, 02 Jun 2022 03:50:02 +0200
Reply-To: waxhead@dirtcellar.net
Subject: Re: Manual intervention options for csum errors
To:     Matthew Warren <matthewwarren101010@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CA+H1V9xQEDf0G-Nvcv3irtSPF+09dJ6VMs7F8LBLpUGEUSfxmg@mail.gmail.com>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <85e0d09e-e1e4-6daf-2ee3-35efaac879b3@dirtcellar.net>
Date:   Thu, 2 Jun 2022 03:50:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 SeaMonkey/2.53.12
MIME-Version: 1.0
In-Reply-To: <CA+H1V9xQEDf0G-Nvcv3irtSPF+09dJ6VMs7F8LBLpUGEUSfxmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Matthew Warren wrote:
> I have FS which is currently not in any sort of raid configuration and
> occasionally a bit flip will occur somewhere on the disk. It would be
> nice to be able to tell BTRFS to recalculate the checksum for that
> specific block and assume the data is correct. For instance, I just
> had this bit flip in the csum for a non-important file which I have an
> external backup of.
> 
> Jun 01 15:58:04 planeptune kernel: BTRFS warning (device nvme0n1p2):
> csum failed root 258 ino 63674380 off 208896 csum 0xa40b3c39 expected
> csum 0xa40b2c39 mirror 1
> 
> This is a very clear case of a csum bitflip and I'd like to have the
> ability to tell BTRFS that the data is correct.
> 
> Matthew Warren
> 
I am just the average user , if anyone picks up this idea I would like 
to throw out an idea. Perhaps something like...

btrfs filesystem (or subvolume) list compromised /mnt which could list 
all the files identified with a unrepairable csum error for example...

1: path/to/file/file1
2: path/to/file/file2
3: path/to/another/filename/somewhere

And then be able to mark damaged files by id as good somehow. Not sure 
how to solve that , but perhaps a "damaged tree" / subvolume dirty bit 
or something along the lines of that would need to be added before that 
would even be possible.
