Return-Path: <linux-btrfs+bounces-17486-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9998BC01A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 07 Oct 2025 05:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0C014F320C
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Oct 2025 03:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BE1217F35;
	Tue,  7 Oct 2025 03:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWuikxWv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6740F217704
	for <linux-btrfs@vger.kernel.org>; Tue,  7 Oct 2025 03:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759807895; cv=none; b=LmUOhxWPJ3ZGF6hj/wHaUVQwM6aaT9HQu9Wo4o/9DZXuD5OsvPoYgBIte/klqBcqGZssf900DOvYnrSOT0FqHM7XhvrmixrZVOttoSv/adYPbc1rzpAFa6NseE8ADzOVX1BJgOz+bVf+GnUUyIowpiApjT3RvdAs2CfR+KkDpDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759807895; c=relaxed/simple;
	bh=a73/itDj+9WAMfQXhR6u7KJ080c9VHBgDSuSF65bk04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WkkoWD7ClkNsRWLC81dvsXe45WKfP51bvY1eytNu11QYRJSGVZrJgKgeBMA2Cl6Yuqr3d8EtfE7OT1YGxa1bKjKBy9DRBLuxQIZ4nrQdVnXYaI2vgPRtFAaRYARxjo676C+99xF9BoL00yz5+0+Rg/WFuFeBNN9ZlwPNKhQS484=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWuikxWv; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-77f3194b322so147526b3a.1
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Oct 2025 20:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759807890; x=1760412690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sRDurbdScmH5WZ+Ymw+Ocyw2kiJSyuCduDlnv9jyTEo=;
        b=KWuikxWv6QYovogDIQHApoHfj46j+JZeMRtnwX3iRkewElpyMfdlivPkP9YlbLHTuE
         Lg8YNdnjW+OHde35zQy991qaFnohvpFr36+JyUcw5OTjeZMXoUrpKaIL6HZhCSVy//MG
         YZUK4+1b8rFHBzcqU7fASZRWL/iYho98QRVibmW4Ulrir9kg/IpsFe0ButZq6HhX+zZ8
         TXJZ8ji/l9XLaeOfQFe5DgfKN/xd2dOKN4zup7IXvgDBx45EIFM/bOHo/JLVuDah+i5w
         vSEiLf8b2QDgNw0oHcfa1TdTbrWsdX6dfe3pdHdX3GbOH6rXX3+Y/ZvL2BDCTeKX1OL5
         8zfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759807890; x=1760412690;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sRDurbdScmH5WZ+Ymw+Ocyw2kiJSyuCduDlnv9jyTEo=;
        b=NsJZ9rHqZJZ+uznwjiv4ZSR6oNrU9n0mYlHjqG2xG2jOK5Tz7a1PYDCWmZu+f0zER6
         xfcdpkpOzMQR3qdNkKJPtO03r4WogU3WlWFHxuVPz4YABhSE7JsF7MBD/dP6/97vNHOi
         pzm88duYoqCNdal65hsnTYijqgsLkCrQelax+XtD+zPz4PgVA5oH7t1smWEUxs7IVUo7
         JeJRJjOEHCQFIvTq1juQtw5kStqBteKgE9vBy5b0MLRvw9Xa741WyvpeX6eAL+rQGXbr
         AxFXQ9h/9ELbfI7/mZNn93pCEA5vnobNv3+bpdJuLkJ17s5/BONNtR++wJJI9gTkYqxc
         KY6Q==
X-Gm-Message-State: AOJu0YzBBsttJlKOP4dEFOAmUqFOwGm//9HfNnm9soDyrgW1CaCa7pHU
	N9zYy1HfJLscWVWf3/AtgybxyOdBFbCM3Masmn2snrlJvbrLfXiS9C35myjpWJJzfbdOUA==
X-Gm-Gg: ASbGncvNJW3yjuVe1F8xdtc+a8KbJKZjtySlYFN9lNc+AxWo8hqCVXEoiSERpzyeC2J
	iRvjgOPG/PTv1ebX1eI6P0NYh++zRr9K/93CYfBYd9174s7WFB0LMyZXubqdapDzZjBYEtnPmUC
	p3EFPgzvUx9BuAtAPdhqPL97KgYvuR8SWgDhCNWM/3YeKPafmW+SoBMtXRvIMox68niFYg45hWA
	niPeAqOhEIJkCt2cB8d8V1+Nh8JXrR6FfROENu96HGVSeW5DUbmYvDwNeV5VWakOR3glhSaD4lo
	NKphprRhsAavCkK8j4fze+cVtdVUJxVkd1HxjF45vsE75Ab+0YeKYSlGzfvzxUPUZp+usp+vYFN
	BPF71EmWRRy3XE6q9joOK9beI6tZrIkWuI+Ljp6ZcgplKlGLa7bKuBkiy
X-Google-Smtp-Source: AGHT+IHYHKbFF0D8TQSQRdYnSBO4jF/jq8sik+9IbtNvIxb93Nk8xS61qHVautM91GyZ+CNSwysA3w==
X-Received: by 2002:a05:6a00:1746:b0:776:165d:e0df with SMTP id d2e1a72fcca58-78c98a74e87mr8713510b3a.0.1759807890151;
        Mon, 06 Oct 2025 20:31:30 -0700 (PDT)
Received: from [192.168.1.13] ([154.3.38.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0209005asm14457986b3a.81.2025.10.06.20.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 20:31:29 -0700 (PDT)
Message-ID: <880ef379-976f-4c52-82fa-03360f9d2736@gmail.com>
Date: Tue, 7 Oct 2025 11:31:26 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <20251004143114.21847-1-sunk67188@gmail.com>
 <20251006181432.GC4412@twin.jikos.cz>
Content-Language: en-US
From: Sun Yangkai <sunk67188@gmail.com>
In-Reply-To: <20251006181432.GC4412@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/7/25 02:14, David Sterba wrote:
> On Sat, Oct 04, 2025 at 10:31:09PM +0800, Sun YangKai wrote:
>> Trivial pattern for the auto freeing with goto -> return conversions.
>> No other function cleanup.
> 
> You could have copied the changelog from previous version, the above is
> too terse.
>>
>> ---
> 
> The --- is a delimiter of the changelog so anything below that untill
> the diff starts will be dropped.
> 
>>
>> Changelog:
>> v1 -> v2:
>> * Add goto -> return conversions
>>
>> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> 
> In this case your signed off that I added manually to the committed
> version.
> 

Thank you David. Your guidance on the mailing list workflow was very helpful, as
I was unfamiliar with it. I'd welcome any further suggestions.

> Below are a few fixups I did in the final version, a few cases to unify
> the returns.
> 
>> @@ -315,14 +284,13 @@ int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info)
>>  	if (ret) {
>>  		if (ret > 0)
>>  			ret = 0;
>> -		goto out;
>> +		return ret;
>>  	}
> 
> The ifs can be untangled to two:
> 
> 	if (ret < 0)
> 		return ret;
> 	if (ret > 0)
> 		return 0;
> 
>>  
>>  	while (1) {
>> -		if (btrfs_fs_closing(fs_info)) {
>> -			ret = -EINTR;
>> -			goto out;
>> -		}
>> +		if (btrfs_fs_closing(fs_info))
>> +			return -EINTR;
>> +
>>  		cond_resched();
>>  		leaf = path->nodes[0];
>>  		slot = path->slots[0];
> 
>> --- a/fs/btrfs/verity.c
>> +++ b/fs/btrfs/verity.c
>> @@ -217,7 +212,7 @@ static int write_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
>>  			   const char *src, u64 len)
>>  {
>>  	struct btrfs_trans_handle *trans;
>> -	struct btrfs_path *path;
>> +	BTRFS_PATH_AUTO_FREE(path);
>>  	struct btrfs_root *root = inode->root;
>>  	struct extent_buffer *leaf;
>>  	struct btrfs_key key;
> 
> One break -> return conversion in the while() loop from after
> btrfs_start_transaction() failure.
> 
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -2034,12 +2024,10 @@ static int btrfs_rm_dev_item(struct btrfs_trans_handle *trans,
>>  	if (ret) {
>>  		if (ret > 0)
>>  			ret = -ENOENT;
>> -		goto out;
>> +		return ret;
>>  	}
>>  
>>  	ret = btrfs_del_item(trans, root, path);
>> -out:
>> -	btrfs_free_path(path);
>>  	return ret;
> 
> Here the btrfs_del_item() can be put to return, it was done in another
> part of this patch too.
> 
>>  }
> 
>> @@ -3048,23 +3029,20 @@ static int btrfs_free_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
>>  
>>  	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
>>  	if (ret < 0)
>> -		goto out;
>> -	else if (unlikely(ret > 0)) { /* Logic error or corruption */
>> +		return ret;
>> +	if (unlikely(ret > 0)) { /* Logic error or corruption */
> 
> Minor style fixup to move the comment to a separate line, you can still
> find that but it's from old code and this is a good time to update it.

After a quick pass through the patch, I noticed another similar case:

@@ -4724,17 +4699,14 @@ int btrfs_recover_balance(struct btrfs_fs_info *fs_info)

 	ret = btrfs_search_slot(NULL, fs_info->tree_root, &key, path, 0, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 	if (ret > 0) { /* ret = -ENOENT; */
-		ret = 0;
-		goto out;
+		return 0;
 	}

> 
>>  		btrfs_err(fs_info, "failed to lookup chunk %llu when freeing",
>>  			  chunk_offset);
>>  		btrfs_abort_transaction(trans, -ENOENT);
>> -		ret = -EUCLEAN;
>> -		goto out;
>> +		return -EUCLEAN;
>>  	}
> 
> Otherwise OK. You don't need to fix and resend the patch. I'm not sure
> if there are more places to convert. If you find some please send them.
> Thanks.

Best reguards,

Sun Yangkai




