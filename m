Return-Path: <linux-btrfs+bounces-21543-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eP/gFRTViWklCAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21543-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 13:37:40 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B883010ECEF
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 13:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F3B9301BF5E
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 12:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B7437756D;
	Mon,  9 Feb 2026 12:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ej2NYX85"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EA037104D
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 12:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770640600; cv=none; b=Fkw02PQ0dIzHM/VIfV02Nuqux7HUiO6pa7UxnhkItmze/h/PDndpV0IHI882jExYj+nMovSLiRXmljP3ARYDKKHzv/mE0Ty1WQMzMlzowECzkL/A9eK7nGKVlmcQAnx/VI9trUx8nZIyaU4TGhmhhH33N6uvOYYQw9z4hUsPHRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770640600; c=relaxed/simple;
	bh=yBp1VQGDiGKZvhzSVT9bOCKUIk6VkRnQQqesj+8ZNYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=izzNGDcDzLKR6xAQbrc8GuWOdXy/si7K937LQIMci2JD3ApDSoeB3AaJO9eBqOCqH5XLwPDSGdo378oVtwDbnDpW78KDfNzTTsRtMcHIAutnhMPHPlDVplkgRyDxR4gIZmAYZ5wfF92ZSNaluASvfZ4JQ53IaVn/rCwUA5GoAzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ej2NYX85; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-4359c54b682so272992f8f.3
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Feb 2026 04:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770640598; x=1771245398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yb4OR6erMoKXOvod9fqHAdvrrTIxetZ3KykLgv096N0=;
        b=ej2NYX85dXMEuuk1lNw5TcSlypkd/395f9cacy8Z2iYRufmZ1yPPNGWWQK1YRx7cEu
         Cr0mggXP7zz+0F6jAkgPlGbx+zC2ci9HbbY3hDv5YZvDH7CZ2STjXCg6NryeBy3uYAvR
         QCakVqvsWtSHnT2+OFQ2qYCZxxYBo1KjkF9j9ARnqdwe5QL/2PR0SPV2mebRpG2BMQ8d
         SOnmr/84v8LPlwzUWI6cKJ1QSoz61U5p9FwCsc5xwcroW/2NxzIcolAgzTWGj+IoftFJ
         lMAHDicHHD13cUAAhY7bXak9nGzXkXTc6aiU9qcpydNyOGSnNcCyG23VCAIws5JEFnv0
         +hbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770640598; x=1771245398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yb4OR6erMoKXOvod9fqHAdvrrTIxetZ3KykLgv096N0=;
        b=Ct9ZHiB5zkWp11Ji+RNCNwJgkZZOTJLVUnbiwk+0GT41tY6L2R9x/JE/NHtX1xUGs7
         2+JyQCRzKehgcxUKXAO1AKikNxKbN4NNG8IjzGMr22Jqr3xcli1Gouqub4aGWF+TYMsw
         LimxYBquMxk0+/Gp1e0nvUvO7njeL6FzrkHH+5PDGAjW1wU+cY6YNj5jTltEbh8qOwzG
         0XslA7XH8175+arJp4q9Z9wmKb9EGkJmEER9aSzHHyfDW9//Y1YpqGnZ+G8OwgqAdpxi
         hE6WFSvKFreIwIXcupdNyjvSQEAzmc26J3MK3mpXmnp4qjbLGIwmKT3kUvWr66kvIWa0
         ONsw==
X-Forwarded-Encrypted: i=1; AJvYcCVnqtcReKkoXnR2/SLMSIxpHMJC9mezdrfTsW6mfIvOycRXkk42YzcB/9Cv0zePndukJLuMq8OjsruRrw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr4hiLcWRC4pUwgSggEI8lIIIf5SBQ/DWJQOGaDr7rnXTuA3w3
	ZEQrZqXtyCRO4n92gDxIkGV0PTIsF6wxijdRw2BSR0my3C/6RjQXrMoj/RKQxHqQKmw=
X-Gm-Gg: AZuq6aKORFcg7eAWCR5TFgJnaQEhM5mPGSv35kmu4qt2IpfuPtB7WQlEMyB7Iyqs8du
	JJE3b5ZdHLvvJ69uWnnoB+ytf6JOKrjK9cQB++lMAMQw5dRKpJSZdUKtWRnp3Q8wCiLSlBvBVV4
	kbmOlRPRzPRC4aRG7WdGYVwlDLgXJVQnHKmgq9Oxzv0WS2lXr5rTXqoZcQbxYhl8aKcOTQRxV7o
	ogYKO2PdxHcptCkPvaMyDbg3xjOWJc8Q7wsLdjbZECChMxy5SxWX+y4uAUu0Yv8qKYDLgUEY90g
	70XztIPToyUUkB0pURafYf6Wdy4P+uWHAzKYD9prNYX1DT+yke5KCtgwlVflzU4tlSyipyB2E8Q
	2TkbdPJuVrNehBsuei9ZtLDxoQZLfAWyQE9bQcE0XVLD73iNooqtta/P9XYCX6MVeCIa0uEQvZS
	WOrfH/9mR1eTJPzJ3TlCelUD5duY2/V+3pKA4JF6/ge7oG/FHh/mPF3urllhIjkcWKog==
X-Received: by 2002:a05:6000:1a8b:b0:432:86e2:8fb5 with SMTP id ffacd0b85a97d-43628ff9bcemr9524110f8f.0.1770640597901;
        Mon, 09 Feb 2026 04:36:37 -0800 (PST)
Received: from ?IPV6:2408:8239:502:5512:d7f8:39da:7a53:51af? ([140.238.217.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376d3a32basm9566012f8f.14.2026.02.09.04.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 04:36:37 -0800 (PST)
Message-ID: <a3334884-c1f7-45ce-8d06-6db85eb49d0f@gmail.com>
Date: Mon, 9 Feb 2026 20:36:26 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix invalid leaf access in btrfs_quota_enable() if
 ref key not found
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <78d48962c97102192c0daea9393b0014430024f0.1770225728.git.fdmanana@suse.com>
Content-Language: en-US
From: Sun YangKai <sunk67188@gmail.com>
In-Reply-To: <78d48962c97102192c0daea9393b0014430024f0.1770225728.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-21543-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunk67188@gmail.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B883010ECEF
X-Rspamd-Action: no action



On 2026/2/5 01:28, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If btrfs_search_slot_for_read() returns 1, it means we did not find any
> key greather than or equals to the key we asked for, meaning we have
> reached the end of the tree and therefore the path is not valid. If
> this happens we need to break out of the loop and stop, instead of
> continuing and accessing an invalid path.
> 
> Fixes: 5223cc60b40a ("btrfs: drop the path before adding qgroup items when enabling qgroups")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/qgroup.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index f53c313ab6e4..ea1806accdca 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1169,11 +1169,14 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
>   			}
>   			if (ret > 0) {
>   				/*
> -				 * Shouldn't happen, but in case it does we
> -				 * don't need to do the btrfs_next_item, just
> -				 * continue.
> +				 * Shouldn't happen because the keu should still
keu -> key

Otherwise, looks good.

Reviewed-by: Sun YangKai <sunk67188@gmail.com>

Thanks,
Sun YangKai
> +				 * be there (return 0), but in case it does it
> +				 * means we have reached the end of the tree -
> +				 * there are no more leaves with items that have
> +				 * a key greater than or equals to @found_key,
> +				 * so just stop the search loop.
>   				 */
> -				continue;
> +				break;
>   			}
>   		}
>   		ret = btrfs_next_item(tree_root, path);


