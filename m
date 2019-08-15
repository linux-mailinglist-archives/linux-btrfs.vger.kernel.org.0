Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4363C8ED7A
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2019 15:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbfHON4F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Aug 2019 09:56:05 -0400
Received: from resqmta-po-07v.sys.comcast.net ([96.114.154.166]:41006 "EHLO
        resqmta-po-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732425AbfHON4B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Aug 2019 09:56:01 -0400
Received: from resomta-po-04v.sys.comcast.net ([96.114.154.228])
        by resqmta-po-07v.sys.comcast.net with ESMTP
        id yFbGhLytoRaDUyGEShBTeC; Thu, 15 Aug 2019 13:56:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1565877360;
        bh=gBQNQXP8Bh5qf65kgSHrrwIbj/iaFNjs91R14kzcrwc=;
        h=Received:Received:Received:Received:Date:From:To:Subject:
         Message-ID:Reply-To:MIME-Version:Content-Type;
        b=kDEgyA8JS/x5mdWRiHOG+nMKAD6pfvA2RVkRZi+RTLFdLExWaLHRlpQSer8pexHmp
         GNgbvyycg+eZgJ5JFnspmCfwwPPn6DV1C+liZY9dis7ik1vtxm7GtZ1KH8Fra2jo7z
         AD5kNvD33v0CsNbujbudxKCf2zsAohAomtuZ6yf7iPFv4wXs5bTmhDXYigck+eu9g+
         e/FF7BT82Qk0jyHRojXDWqCXkWKiwVLDaYuGmNZMlMYwFoFRu0he6//sUo+p6tLUFh
         t0/y1H2NjNfDJvq3rlwjofbd8mhNjRCmky9MQWgKyvQg0Zx7z33biI6vfsudFWQcLL
         JufTnliHFd8fA==
Received: from beta.localdomain ([73.209.109.78])
        by resomta-po-04v.sys.comcast.net with ESMTPA
        id yGERh9GiFGJEUyGEShtNMG; Thu, 15 Aug 2019 13:56:00 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgeduvddrudefuddgieelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvehomhgtrghsthdqtfgvshhipdfqfgfvpdfpqffurfetoffkrfenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkrhhfgggtuggjvggfsehttdertddtredvnecuhfhrohhmpefvihhmucghrghlsggvrhhguceothifrghlsggvrhhgsegtohhmtggrshhtrdhnvghtqeenucfkphepjeefrddvtdelrddutdelrdejkeenucfrrghrrghmpehhvghlohepsggvthgrrdhlohgtrghlughomhgrihhnpdhinhgvthepjeefrddvtdelrddutdelrdejkedpmhgrihhlfhhrohhmpehtfigrlhgsvghrghestghomhgtrghsthdrnhgvthdprhgtphhtthhopehquhifvghnrhhuohdrsghtrhhfshesghhmgidrtghomhdprhgtphhtthhopehtfigrlhgsvghrghestghomhgtrghsthdrnhgvthdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-Xfinity-VMeta: sc=0;st=legit
Received: from calvin.localdomain ([10.0.0.8])
        by beta.localdomain with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <twalberg@comcast.net>)
        id 1hyGEQ-0007J8-UE; Thu, 15 Aug 2019 08:55:59 -0500
Received: from tew by calvin.localdomain with local (Exim 4.84_2)
        (envelope-from <tew@calvin.localdomain>)
        id 1hyGEQ-0003ds-Pl; Thu, 15 Aug 2019 08:55:58 -0500
Date:   Thu, 15 Aug 2019 08:55:58 -0500
From:   Tim Walberg <twalberg@comcast.net>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Tim Walberg <twalberg@comcast.net>, linux-btrfs@vger.kernel.org
Subject: Re: recovering from "parent transid verify failed"
Message-ID: <20190815135558.GD2731@comcast.net>
Reply-To: Tim Walberg <twalberg@comcast.net>
References: <20190814183213.GA2731@comcast.net>
 <4be5086f-61e7-a108-8036-da7d7a5d5c11@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4be5086f-61e7-a108-8036-da7d7a5d5c11@gmx.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Also - here's 'btrfs inspect-internal dump-super /dev/sdc1':

superblock: bytenr=65536, device=/dev/sdc1
---------------------------------------------------------
csum_type   0 (crc32c)
csum_size   4
csum	  0x4331039b [match]
bytenr	    65536
flags	  0x1
      ( WRITTEN )
magic	  _BHRfS_M [match]
fsid	  53749823-faaf-46f9-866d-3778d93cb1ca
label	  btrfs1
generation    49750
root	  229846646784
sys_array_size	  129
chunk_root_generation 49725
root_level    1
chunk_root    2568857059328
chunk_root_level  1
log_root    0
log_root_transid  0
log_root_level	  0
total_bytes   9001775738880
bytes_used    2085801975808
sectorsize    4096
nodesize    16384
leafsize (deprecated)	16384
stripesize    4096
root_dir    6
num_devices   3
compat_flags	0x0
compat_ro_flags	  0x0
incompat_flags	  0x361
      ( MIXED_BACKREF |
        BIG_METADATA |
        EXTENDED_IREF |
        SKINNY_METADATA |
        NO_HOLES )
cache_generation  49748
uuid_tree_generation  49748
dev_item.uuid	7338a973-9a45-4032-a4c9-d18142fd7908
dev_item.fsid	53749823-faaf-46f9-866d-3778d93cb1ca [match]
dev_item.type	0
dev_item.total_bytes  3000591912960
dev_item.bytes_used 1407675531264
dev_item.io_align 4096
dev_item.io_width 4096
dev_item.sector_size  4096
dev_item.devid	  1
dev_item.dev_group  0
dev_item.seek_speed 0
dev_item.bandwidth  0
dev_item.generation 0


Although, 'btrfs inspect-internal logical-resolve ...' just says:

# btrfs inspect-internal logical-resolve 229846466560 /dev/sdc1
ERROR: not a btrfs filesystem: /dev/sdc1



On 08/15/2019 10:35 +0800, Qu Wenruo wrote:
>>	
>>	
>>	On 2019/8/15 ??????2:32, Tim Walberg wrote:
>>	> Most of the recommendations I've found online deal with when "wanted" is
>>	> greater than "found", which, if I understand correctly means that one or
>>	> more transactions were interrupted/lost before fully committed.
>>	
>>	No matter what the case is, a proper transaction shouldn't have any tree
>>	block overwritten.
>>	
>>	That means, either the FLUSH/FUA of the hardware/lower block layer is
>>	screwed up, or the COW of tree block is already screwed up.
>>	
>>	> 
>>	> Are the recommendations for recovery the same if the system is reporting a
>>	> "wanted" that is less than "found"?
>>	> 
>>	The salvage is no difference than any transid mismatch, no matter if
>>	it's larger or smaller.
>>	
>>	It depends on the tree block.
>>	
>>	Please provide full dmesg output and btrfs check for further advice.
>>	
>>	Thanks,
>>	Qu
>>	



End of included message



-- 
+----------------------+
| Tim Walberg          |
| 830 Carriage Dr.     |
| Algonquin, IL 60102  |
| twalberg@comcast.net |
+----------------------+
