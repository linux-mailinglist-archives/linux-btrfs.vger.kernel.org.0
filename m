Return-Path: <linux-btrfs+bounces-12169-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D16A5B1AA
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 01:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F0A3AE9C1
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 00:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763AF29A5;
	Tue, 11 Mar 2025 00:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izd86GLC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B4815A8
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 00:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741651914; cv=none; b=ehe04OgQPPe5bfeEItggk/HkhnAPtugNVUKsQM1Dlo6jZLJ/YEL//QXzdr0Gi/QtveEeet9X7L5hTuoD2EDBSgm1U2C/isYSMTwN73SR3U+3Zmn0Cz3jS3QWduhRFtzXr2+K/W7GhQ+2+9tEE4f+Cy2qbuJ6krx5K7Nho7RNNIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741651914; c=relaxed/simple;
	bh=yi2sjQPWOLa8CB07HciGFqSUUdSIeP6PN3Xo0qxAjHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SNP6kxWh4VMscP1gLclKXuTaVE3e3NvappWtylzTtG9O7lt6+VpkB4hF35LXCCpCHhte+FmmIv2wvStlACJri+J1DtySOX40EhUuVd4q5Y1xMaXqN1Tb0yN8M/9Y+QvGnRypST1M6it7QaA7u2REZGqZQRUBIr8zsRWXsN9+qDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izd86GLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F34C4CEE5;
	Tue, 11 Mar 2025 00:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741651914;
	bh=yi2sjQPWOLa8CB07HciGFqSUUdSIeP6PN3Xo0qxAjHI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=izd86GLC/s83OosRj+Nj7tShK+EtT1iJxelWX4JHpqFrj6vz+3TdZehVInw+gnG5l
	 SrBGHENdQinOaepo/vKuTo/Qgmk7XRWmaFVS0/8rfYcp4AldVvZEqZXo4fvdGdMr4Z
	 l/obV23fFjxFFFo+Rh13Rjl+0pnJu2rX43nyQdCFJySixBTjcm7PeZEEKCAXg+UxOP
	 kQQVdwlYJVoadqwesciYYS8+LYpPczrTzArx7nI8bwImYXDLT+vX/WIRppaMOALWY5
	 tttpHNj30tbXCKf0xHGmh7byJIPO+TT4CMeelCuPz2N8PByDBMeuF4pIS1JvbhLMd/
	 6pX6+U1YwuYEw==
Message-ID: <46d9ffa1-3cad-4192-9d8a-5c37ea3a33e8@kernel.org>
Date: Tue, 11 Mar 2025 09:11:52 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] btrfs: add new ioctl CLEAR_FREE
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 David Sterba <dsterba@suse.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 Naohiro Aota <Naohiro.Aota@wdc.com>
References: <cover.1740753608.git.dsterba@suse.com>
 <ecc43a72997ae7836c2d227b69924d364698e665.1740753608.git.dsterba@suse.com>
 <0cb33e7e-4390-4647-a277-221f9ddf3640@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <0cb33e7e-4390-4647-a277-221f9ddf3640@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 01:38, Johannes Thumshirn wrote:
> On 28.02.25 15:49, David Sterba wrote:
>> Add a new ioctl that is an extensible version of FITRIM. It currently
>> does only the trim/discard and will be extended by other modes like
>> zeroing or block unmapping.
>>
>> We need a new ioctl for that because struct fstrim_range does not
>> provide any existing or reserved member for extensions. The new ioctl
>> also supports TRIM as the operation type.
>>
>> Signed-off-by: David Sterba <dsterba@suse.com>
> 
> [...]
> 
> I /think/ we need some extra checks for zoned here. blkdev_issue_zeroout 
> won't work on zoned devices IFF the 'start' range is not aligned to the 
> write pointer. Also blkdev_issue_discard() on 'unused space' of a zoned 
> filesystem won't do what a user is expecting.

Zoned SAS HDDs can support discard on conventional zones. And if they do not, we
can still do the emulated zeroout on conventional zones.
For sequential zones, we can do a zone reset of all zones that have been written
but have all blocks free (so unused).

> 
> I think this needs:
> 
>> +static int btrfs_ioctl_clear_free(struct file *file, void __user *arg)
>> +{
>> +	struct btrfs_fs_info *fs_info;
>> +	struct btrfs_ioctl_clear_free_args args;
>> +	u64 total_bytes;
>> +	int ret;
>> +
>> +	if (!capable(CAP_SYS_ADMIN))
>> +		return -EPERM;
> 
> 	if (btrfs_is_zoned(fs_info))
> 		return -EOPNOTSUPP;

With the above observations, this may be a bit too harsh. Though it is probably
fine for now for zones, but adding a comment mentioning the above things we
could do may be good as a reminder for later improvements.

> 
>> +
>> +	if (copy_from_user(&args, arg, sizeof(args)))
>> +		return -EFAULT;
>> +
>> +	if (args.type >= BTRFS_NR_CLEAR_OP_TYPES)
>> +		return -EOPNOTSUPP;
>> +
>> +	ret = mnt_want_write_file(file);
>> +	if (ret)
>> +		return ret;
>> +
>> +	fs_info = inode_to_fs_info(file_inode(file));
>> +	total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
>> +	if (args.start > total_bytes) {
>> +		ret = -EINVAL;
>> +		goto out_drop_write;
>> +	}
>> +
>> +	ret = btrfs_clear_free_space(fs_info, &args);
>> +	if (ret < 0)
>> +		goto out_drop_write;
>> +
>> +	if (copy_to_user(arg, &args, sizeof(args)))
>> +		ret = -EFAULT;
>> +
>> +out_drop_write:
>> +	mnt_drop_write_file(file);
>> +
>> +	return 0;
>> +}
>> +


-- 
Damien Le Moal
Western Digital Research

