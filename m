Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7564C7080
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 16:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbiB1PZV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 28 Feb 2022 10:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiB1PZU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 10:25:20 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6039D45ADF
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 07:24:39 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5AA8E2086C;
        Mon, 28 Feb 2022 15:24:38 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 5EB5420629;
        Mon, 28 Feb 2022 15:24:37 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1646061877; a=rsa-sha256;
        cv=none;
        b=OQrF1lJ7jVGY1J1erAzkiITEbtTngjQY/NgY7OWYE3DOgy5inXlIS1vYiah6reQnbDPVJ/
        J1we/X8NLXkR+UrVQCGG+77iSqdnxWZ+hZ3XNXSMhzOkf7HAdn07NGvmPEK1ZS37r8lOhg
        qEu2LnR6vx8Key9R9LG8Xp5rhcDcHI4ldIK+gIg+8BpeFHhisR6OX6/mWlcyhMaoisYBJE
        K4qV3dpsWrnq20qpWDxJb8mEo1TYP/VNFUxPznjtYx8Jg1bU7KXDLj2vPIFddwqmcxbrvW
        f/uHPfRl+xzH666ddr2qbKl5osN/zxjT3sx01QSdXmDe1R/N5/nRK+8yvfqddA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1646061877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WY2Up+Y0QaCUrAJ79l8zybXORuxnjgfc7A9ArDu29Qc=;
        b=mvVD+LZVR3bWrM7lExnE1rEWv4qqkgR/ioMbxG2UzVM+KsJ55k8DteGmic5n98q8Z5Jnhr
        in1vFlNJzCrRyVW1OnF4vOGY547/OpS5Htr74/Ufls4wRz5m0ox9cAMd3B1K9P5ITiE8o3
        Xcf9IvIkx32zrx3iEAYSq4k/Ttb+b/cg9P0oZNesNnmcGmKqC7LFMnPOtD79N0eruQGex/
        PkY0sgu+lKLZON5ITFyCr8mZ4tTYD9tFW1yZCEsNOBYo0Y/EGVOnGEli09lrfG0XetREQ8
        b4K96MfzARhNHlknoB/lrLp+y/qGrK/LAhFiMb83rzcBncZN7VQAf/WAS0X1lQ==
ARC-Authentication-Results: i=1;
        rspamd-56df6fd94d-66vm5;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.115.218.36 (trex/6.5.3);
        Mon, 28 Feb 2022 15:24:38 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Plucky-Wiry: 5b6776606288c2a9_1646061878137_2841662058
X-MC-Loop-Signature: 1646061878137:172146789
X-MC-Ingress-Time: 1646061878137
Received: from ppp-88-217-35-91.dynamic.mnet-online.de ([88.217.35.91]:58954 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1nOht0-0002tn-Oy; Mon, 28 Feb 2022 15:24:35 +0000
Message-ID: <74ccc4a0bbd181dd547c06b32be2b071612aeb85.camel@scientia.org>
Subject: Re: BTRFS error (device dm-0): parent transid verify failed on
 1382301696 wanted 262166 found 22
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date:   Mon, 28 Feb 2022 16:24:29 +0100
In-Reply-To: <edefb747-0033-717d-5383-f8c2f22efc8f@gmx.com>
References: <2dfcbc130c55cc6fd067b93752e90bd2b079baca.camel@scientia.org>
         <5eb2e0c2-307b-0361-2b64-631254cf936c@gmx.com>
         <f7270877b2f8503291d5517f22068a2f3829c959.camel@scientia.org>
         <ff871fa3-901f-1c30-c579-2546299482da@gmx.com>
         <22f7f0a5c02599c42748c82b990153bf49263512.camel@scientia.org>
         <edefb747-0033-717d-5383-f8c2f22efc8f@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.43.2-2 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-0.5
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 2022-02-28 at 14:48 +0800, Qu Wenruo wrote:
> Btrfs handles checksum differently for metadata (tree block) and
> data.
> 
> For metadata, its header has 32 bytes reserved for checksum, and
> that's
> where the csum of metadata is.
> Aka, inlined checksum.

Ah, I see.


> For the best case, it's just a leave got this corruption.
> In that case, if you're using SHA256 and 16K nodesize, you get at
> most
> 2MiB range which can not be read.
> (Again, on disk data can still be fine)

It would be interesting to see how much is actually affected,...
shouldn't it be possible to run something like dd_rescue on it? I mean
I'd probably get thousands of csum errors, but in the end it should
show me how much of the file is gone.



> 
> Depends on the generation. If your current generation (can be checked
> with btrfs ins dump-super) is close to the number 262166, then it's
> possible it's rewritten recently.


Hmm, I assume it's just "main" generation field?

Then the number would be *pretty* much off. Which makes the whole thing
IMO quite strange... as said, the file was written around 2019,... and
it had been sent/received at least once.

So would expect that the corruption or bit-flip would need to have
happened at some point after it was first sent/received?


# btrfs inspect-internal dump-super -f /dev/mapper/system  
superblock: bytenr=65536, device=/dev/mapper/system
---------------------------------------------------------
csum_type		0 (crc32c)
csum_size		4
csum			0x80b351a8 [match]
bytenr			65536
flags			0x1
			( WRITTEN )
magic			_BHRfS_M [match]
fsid			1639c139-9033-48a6-80ac-3f7103f5421a
metadata_uuid		1639c139-9033-48a6-80ac-3f7103f5421a
label			system
generation		2233998
root			1743650816
sys_array_size		97
chunk_root_generation	2115390
root_level		1
chunk_root		1048576
chunk_root_level	1
log_root		1749876736
log_root_transid	0
log_root_level		0
total_bytes		1006093991936
bytes_used		658049802240
sectorsize		4096
nodesize		16384
leafsize (deprecated)	16384
stripesize		4096
root_dir		6
num_devices		1
compat_flags		0x0
compat_ro_flags		0x0
incompat_flags		0x161
			( MIXED_BACKREF |
			  BIG_METADATA |
			  EXTENDED_IREF |
			  SKINNY_METADATA )
cache_generation	2233998
uuid_tree_generation	2233998
dev_item.uuid		61917e72-aada-41c5-846b-cd1f73a7fcd8
dev_item.fsid		1639c139-9033-48a6-80ac-3f7103f5421a [match]
dev_item.type		0
dev_item.total_bytes	1006093991936
dev_item.bytes_used	851498237952
dev_item.io_align	4096
dev_item.io_width	4096
dev_item.sector_size	4096
dev_item.devid		1
dev_item.dev_group	0
dev_item.seek_speed	0
dev_item.bandwidth	0
dev_item.generation	0
sys_chunk_array[2048]:
	item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 1048576)
		length 4194304 owner 2 stripe_len 65536 type SYSTEM|single
		io_align 4096 io_width 4096 sector_size 4096
		num_stripes 1 sub_stripes 0
			stripe 0 devid 1 offset 1048576
			dev_uuid 61917e72-aada-41c5-846b-cd1f73a7fcd8
backup_roots[4]:
	backup 0:
		backup_tree_root:	1743650816	gen: 2233998	level: 1
		backup_chunk_root:	1048576	gen: 2115390	level: 1
		backup_extent_root:	1741438976	gen: 2233998	level: 2
		backup_fs_root:		637187178496	gen: 2232658	level: 0
		backup_dev_root:	1230602240	gen: 2233971	level: 1
		backup_csum_root:	1731887104	gen: 2233998	level: 2
		backup_total_bytes:	1006093991936
		backup_bytes_used:	658049802240
		backup_num_devices:	1

	backup 1:
		backup_tree_root:	1749188608	gen: 2233995	level: 1
		backup_chunk_root:	1048576	gen: 2115390	level: 1
		backup_extent_root:	1747468288	gen: 2233995	level: 2
		backup_fs_root:		637187178496	gen: 2232658	level: 0
		backup_dev_root:	1230602240	gen: 2233971	level: 1
		backup_csum_root:	1711751168	gen: 2233995	level: 2
		backup_total_bytes:	1006093991936
		backup_bytes_used:	658049695744
		backup_num_devices:	1

	backup 2:
		backup_tree_root:	1754923008	gen: 2233996	level: 1
		backup_chunk_root:	1048576	gen: 2115390	level: 1
		backup_extent_root:	1746878464	gen: 2233996	level: 2
		backup_fs_root:		637187178496	gen: 2232658	level: 0
		backup_dev_root:	1230602240	gen: 2233971	level: 1
		backup_csum_root:	1711423488	gen: 2233996	level: 2
		backup_total_bytes:	1006093991936
		backup_bytes_used:	658049695744
		backup_num_devices:	1

	backup 3:
		backup_tree_root:	1761574912	gen: 2233997	level: 1
		backup_chunk_root:	1048576	gen: 2115390	level: 1
		backup_extent_root:	1751040000	gen: 2233997	level: 2
		backup_fs_root:		637187178496	gen: 2232658	level: 0
		backup_dev_root:	1230602240	gen: 2233971	level: 1
		backup_csum_root:	1716748288	gen: 2233997	level: 2
		backup_total_bytes:	1006093991936
		backup_bytes_used:	658049806336
		backup_num_devices:	1



On Mon, 2022-02-28 at 14:54 +0800, Qu Wenruo wrote:> 
> It may not be a single file, but a lot of files.

Shouldn't I be able to find out simply by copying away each file (like
what I did during yesterday's backup)?
Or something like tar -cf /dev/null /

Every file that tar cannot read should give an error, and I'd see which
are affected?


> As csum tree only stores two things, logical bytenr, and its csum.
> 
> So we need some work to find out:
> 
> 1) Which logical bytenr range is in that csum tree block
> 
> 2) Which files owns the logical bytenr range.

Is this possible already with standard tools?


 
> No common operations can help.
> 
> But I can craft you a special fix to manually reset the generation of
> that offending csum tree block, as a last resort method.

I guess, if you'd say that the above way would work to find out which
file was affected, and if it was only that one (which is not
precious)... than I could simply copy all data off to some external
disk, an just re-create the fs.


If I'd delete the affected file(s) would btrfs simply clear the broken
csum block?

 
> We have a way, since v5.11, we have a new mount option,
> rescue=idatacsums, which can do exactly that, completely ignore data
> csums.

Ah :-)


Thanks,
Chris.


PS: I'll start the memtest now, and report back once I have some news.
