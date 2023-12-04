Return-Path: <linux-btrfs+bounces-554-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9744802FBE
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 11:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9C11C20A61
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 10:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BEF1F95A;
	Mon,  4 Dec 2023 10:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b="pZQH1vHo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-108-mta234.mxroute.com (mail-108-mta234.mxroute.com [136.175.108.234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6269EB6
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 02:11:07 -0800 (PST)
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta234.mxroute.com (ZoneMTA) with ESMTPSA id 18c344f5e25000190b.002
 for <linux-btrfs@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 04 Dec 2023 10:11:05 +0000
X-Zone-Loop: aba6d9379e651e2404d60a85585b7370412970c488ea
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=damenly.org
	; s=x; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Z2zlbWCfe29mY4GMjdCcTHBsOnnwJsdrumce4OlciRg=; b=pZQH1vHoHnVT9Scvwg4J8Mtu+c
	UNFIAHOLn95uu7injbWZwVmO0JAo26GAJD4w+Eck7h41frQLKhPuUCW/3qj2W/2OE/wS/E90h/5v9
	DiVDTjYhjVePoAQOK21Pp1JSse262T9o1QqP/byr7tWMdOzS5U66BNRWVDZE9cBVyVpEiyaVa+cYN
	/SlaukT0TBk9vuHDe31jpPEremDsxt+uXXApjLM0u5PS6svDE5CRKmlFRMS7gNHB0sh5K4TAB05Pl
	sEv2rwH2OpWtsPUaib6+p4bT69MkjOanYrpnS+P1ubneCP1IPnGSNwyfL2b9okmUb5MiGIBNPSoFa
	IqXAJ3bw==;
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 04 Dec 2023 10:11:04 +0000
From: l@damenly.org
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs-progs: tune: add fsck runs before and after a
 full conversion
In-Reply-To: <a5qqguz5.fsf@damenly.org>
References: <cover.1701672971.git.wqu@suse.com>
 <f919ead47c266bbb4c24ba873e565e4c36b9377a.1701672971.git.wqu@suse.com>
 <a5qqguz5.fsf@damenly.org>
Message-ID: <455ec3c5adf1dbb10f5ee00bf3a6c955@damenly.org>
X-Sender: l@damenly.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: l@damenly.org

On 2023-12-04 09:44, Su Yue wrote:
> On Mon 04 Dec 2023 at 17:26, Qu Wenruo <wqu@suse.com> wrote:
> 
>> We have two bug reports in the mailing list around block group tree
>> conversion.
>> 
>> Although currently there is still no strong evidence showing btrfstune
>> is the culprit yet, I still want to be extra cautious.
>> 
>> This patch would add an extra safenet for the end users, that a full
>> readonly btrfs check would be executed on the filesystem before doing
>> any full fs conversion (including bg/extent tree and csum conversion).
>> 
>> This can catch any existing health problem of the filesystem.
>> 
>> Furthermore, after the conversion is done, there would also be a 
>> "btrfs
>> check" run, to make sure the conversion itself is fine, to make sure 
>> we
>> have done everything to make sure the problem is not from our side.
>> 
>> One thing to note is, the initial check would only happen on a source
>> filesystem which is not under any existing conversion.
>> As a fs already under conversion can easily trigger btrfs check false
>> alerts.
>> 
> Better to mention above behavior in documentation too? Or some
> impatient people may give up then complain btrfs is slow ;)
> 
And maybe an option to skip check? People who want to convert to BG tree
usually have large filesystems, then the original check can be killed
because of OOM...

--
Su

> --
> Su
>> 
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  Makefile    |  3 ++-
>>  tune/main.c | 55  
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 57 insertions(+), 1 deletion(-)
>> 
>> diff --git a/Makefile b/Makefile
>> index 374f59b99150..47c6421781f3 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -267,7 +267,8 @@ mkfs_objects = mkfs/main.o mkfs/common.o 
>> mkfs/rootdir.o
>>  image_objects = image/main.o image/sanitize.o  image/image-create.o 
>> image/common.o \
>>  		image/image-restore.o
>>  tune_objects = tune/main.o tune/seeding.o tune/change-uuid.o  
>> tune/change-metadata-uuid.o \
>> -	       tune/convert-bgt.o tune/change-csum.o common/clear-cache.o 
>> tune/quota.o
>> +	       tune/convert-bgt.o tune/change-csum.o common/clear-cache.o 
>> tune/quota.o \
>> +	       check/main.o check/mode-common.o check/mode-lowmem.o 
>> mkfs/common.o
>>  all_objects = $(objects) $(cmds_objects) $(libbtrfs_objects)  
>> $(convert_objects) \
>>  	      $(mkfs_objects) $(image_objects) $(tune_objects)  
>> $(libbtrfsutil_objects)
>> 
>> diff --git a/tune/main.c b/tune/main.c
>> index 9dcb55952b59..f05ab7c3b36e 100644
>> --- a/tune/main.c
>> +++ b/tune/main.c
>> @@ -29,6 +29,7 @@
>>  #include "kernel-shared/transaction.h"
>>  #include "kernel-shared/volumes.h"
>>  #include "kernel-shared/free-space-tree.h"
>> +#include "kernel-shared/zoned.h"
>>  #include "common/utils.h"
>>  #include "common/open-utils.h"
>>  #include "common/device-scan.h"
>> @@ -367,6 +368,47 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>>  	if (change_metadata_uuid || random_fsid || new_fsid_str)
>>  		ctree_flags |= OPEN_CTREE_USE_LATEST_BDEV;
>> 
>> +	/*
>> +	 * For fs rewrites operations, we need to verify the initial
>> +	 * filesystem to make sure they are healthy.
>> +	 * Otherwise the transaction protection is not going to save us.
>> +	 */
>> +	if (to_bg_tree || to_extent_tree || csum_type != -1) {
>> +		struct btrfs_super_block sb = { 0 };
>> +		u64 sb_flags;
>> +
>> +		/*
>> +		 * Here we just read out the superblock without any extra check,
>> +		 * as later btrfs_check() would do more comprehensive check on
>> +		 * it.
>> +		 */
>> +		ret = sbread(fd, &sb, 0);
>> +		if (ret < 0) {
>> +			errno = -ret;
>> +			error("failed to read super block from \"%s\"", device);
>> +			goto free_out;
>> +		}
>> +		sb_flags = btrfs_super_flags(&sb);
>> +		/*
>> +		 * If we're not resuming the conversion, we should check the fs
>> +		 * first.
>> +		 */
>> +		if (!(sb_flags & (BTRFS_SUPER_FLAG_CHANGING_BG_TREE |
>> +				  BTRFS_SUPER_FLAG_CHANGING_DATA_CSUM |
>> +				  BTRFS_SUPER_FLAG_CHANGING_META_CSUM))) {
>> +			bool check_ret;
>> +			struct btrfs_check_options options =
>> +				btrfs_default_check_options;
>> +
>> +			check_ret = btrfs_check(device, &options);
>> +			if (check_ret) {
>> +				error(
>> +		"\"btrfs check\" found some errors, will not touch the 
>> filesystem");
>> +				ret = -EUCLEAN;
>> +				goto free_out;
>> +			}
>> +		}
>> +	}
>>  	root = open_ctree_fd(fd, device, 0, ctree_flags);
>> 
>>  	if (!root) {
>> @@ -535,6 +577,19 @@ out:
>>  	}
>>  	close_ctree(root);
>>  	btrfs_close_all_devices();
>> +	/* A sucessful run finished, let's verify the fs again. */
>> +	if (!ret && (to_bg_tree || to_extent_tree || csum_type)) {
>> +		bool check_ret;
>> +		struct btrfs_check_options options = btrfs_default_check_options;
>> +
>> +		check_ret = btrfs_check(device, &options);
>> +		if (check_ret) {
>> +			error(
>> +	"\"btrfs check\" found some errors after the conversion, please 
>> contact the developers");
>> +			ret = -EUCLEAN;
>> +		}
>> +
>> +	}
>> 
>>  free_out:
>>  	return ret;

