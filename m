Return-Path: <linux-btrfs+bounces-19980-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED542CD8307
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 06:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2168A30309B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 05:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112C12F6925;
	Tue, 23 Dec 2025 05:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1L+FowU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD152F5474
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Dec 2025 05:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766468242; cv=none; b=O7PdoxijHA2QNbzYsdZwQI/iFFhINNnQKmrb81Pm0yV9/8ahOxWQgw9e6wCyK/Hi4Km4xrxYHArPnCs6caFyyPOZ5G4ryQNg0iCjw1gdt3Iylw3FyaiUWjrm93ngBPM58fmRU8TiWey/H/4grRikPWxva8Bk2gF10dZpDtr6Xxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766468242; c=relaxed/simple;
	bh=PhRs88mwlwkazk+ENj6MoiJDiZn71PTbJFD0EWthhgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SofpC52g4DAykYo4BvSTGGNdAtT0gywyfoUPsXFdmiqvjpwyyy5++RrgmbEcsyg00lwPgH4qT1lx6fBvdlbpo7pMB8vNNXiYriOqtdUjnMltWCcRzy+RV2FMUxLOPuLdnILQXw95/k9wL3ZtuDPu4A2RKQmKz7kWhVg1n38E884=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1L+FowU; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29efd139227so62100005ad.1
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Dec 2025 21:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766468238; x=1767073038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A82QF1EkZtulULncIKG5BayS1YlCBJFC1tpTXCRjsWA=;
        b=m1L+FowUPIMlYK4jS0rqd66lJOxSEu9UNgALQ5BaPsZY0mYIff/6weYhiZEE+MrrkM
         9aobe9ahzY2NcVvdmuxqVWtMOkmapJ04qlH+b0btXifJRKnEEtPaUiqLsELDhj6jt70w
         EK7sGlcQ5d76EwzvypNKWSgDYHmPE+8BHcUbIBj4EI4NxbY3KKCwI4ZDp1KQgpy98Bs5
         C6GPDqRf9SXQuuaRHvzF4K3LE21rBYkM/shcj4phJZQDM3tLR9Z+daG+i6MPaX8M21Le
         aEgz9SUcfIi+tbtgXj18ewhgT+GqS2CX4Nhkk1K9SsmOF/RYGt1NhIV1GMZhSPb1cXVy
         zIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766468238; x=1767073038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A82QF1EkZtulULncIKG5BayS1YlCBJFC1tpTXCRjsWA=;
        b=NjhpUePtfJSA6HwemEwzpLZZpfbO5OOHnK/g6ZaB2X1rrFhWiQcMKHAIQ7dYJlaAB3
         0WTeBI3PiPn0RfhSBnh+0/CMTg5OoZomUk1MQwclS/8U2yeDiMmiPvxF5aIM6b/BbFZQ
         VsNB1nQIJaRPhOTuhkcQ48QavT4hYZMKIBBhmHORiQDyhMzyHQaSW2oY+9wIsJaoDom3
         LBDTJekS79slfyClxrDIMY+0XIzQ5xwfx+bSH6Fa9XUiblldG5uEnPiGjGEgi7S8m1Sa
         S8Modd0v5VhTho75cPig11gXIiOwsSsHfJLNOHGMD/7T8fXelFNoAm65mwVJit5lcFSD
         qdrA==
X-Forwarded-Encrypted: i=1; AJvYcCV/EnX4WyCBsM2TCZ15PYrM/bA05XD6UydaG0d0ZpSu3eAKaAjexNNRolkzH80icUj75cGeiZCmV6Dn7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoKk+1iIGI0UwHUcJW/REOJIqevbR4X5AGA0ADjyVnOsCKGn7y
	E/9ch5PaIYs8g+DjAjG9vKwcP2b5MJJULIMnCPRJrw/apNHJ8BBSVadN
X-Gm-Gg: AY/fxX4qn4zAJBWjR8JgZRXBb6VAX8hqFyuwuOekY7JArFEZN9upL7QH9BfrMHCg0oe
	96fM7svVUDlC2ljE6mqoZ2ZMhQbMrMqUKyx8WI/lrLXTDLF6+HGlKgOEJ1XowsbM47zQ317FQ6j
	J9PghxSowjUbwsR0/g7cnRC+2JFg4m0ZkAGjK+SZxsW6+lxKgWj0nhX1nyFpJvLVJASUPcc+5dq
	SulExqm3eFLh9v6/7MG8Xn1H7qbVdokjSh2wyugmKOGIRuveo782yOwc9IHAcBcVDCxccnfDsLB
	jgOFnBmJjXT0RGvnvedvPE6PKY1mJizyGRih2kdwTviQ2nmdwYM/nJKEaNq7IjzTIwQLsQiix3X
	sYzIuvAyBIvGvtBXHAYRs2ANB6jTpIpvkLq+EG21NWi/SdSmgCKtKKU2XdvY7zISwsuH2t/oCue
	PKrhqsBYCY8Uefla0khy35Vi81auJWYqE/v9NZh4cYZzKeI/ptG9K+EdLakPU2UhhSRynr3TxVa
	jI=
X-Google-Smtp-Source: AGHT+IFuAa1bEi9iXQ/fVsFOwY92P7NTqag0Itb/bLEcgCW/+Bj05+w6CIPRTwzaf559s5BnxudUFg==
X-Received: by 2002:a05:7022:1e01:b0:11a:5ee1:fd8a with SMTP id a92af1059eb24-121722ab372mr13830811c88.13.1766468237569;
        Mon, 22 Dec 2025 21:37:17 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab? ([2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfd95sm52514131c88.1.2025.12.22.21.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 21:37:17 -0800 (PST)
Message-ID: <5789c903-d3f6-4c41-b342-8d29387688e5@gmail.com>
Date: Mon, 22 Dec 2025 21:37:16 -0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] fs: add a ->sync_lazytime method
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
 Jan Kara <jack@suse.cz>, Mike Marshall <hubcap@omnibond.com>,
 Martin Brandenburg <martin@omnibond.com>, Carlos Maiolino <cem@kernel.org>,
 Stefan Roesch <shr@fb.com>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
 io-uring@vger.kernel.org, devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251223003756.409543-1-hch@lst.de>
 <20251223003756.409543-8-hch@lst.de>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20251223003756.409543-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/25 16:37, Christoph Hellwig wrote:
> Allow the file system to explicitly implement lazytime syncing instead
> of pigging back on generic inode dirtying.  This allows to simplify
> the XFS implementation and prepares for non-blocking lazytime timestamp
> updates.
>
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Jeff Layton<jlayton@kernel.org>


Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck


