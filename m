Return-Path: <linux-btrfs+bounces-10154-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 760CD9E8B59
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 07:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424FE1885A80
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 06:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A802213E8E;
	Mon,  9 Dec 2024 06:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="K2mh6NCZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E913616DEB5
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Dec 2024 06:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733724635; cv=none; b=lLzbZ5NTmX/DR8IyJk1XcEe7LouURhryhF20rIzvx6E7ktI2wHA+Y21uir3KF2qrwNYtl1sY0EoCgnXnbqBIzN4PBHh8AEfTZr9Mj/9SHDlIGFlmKR2CPP9T1xyjGLqsF6vBdXQdCZByF4wTD/qQDKR363HcwxVXvuwkLO5T8gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733724635; c=relaxed/simple;
	bh=f7V0VQg/Zi8pHPWCU3DDStLHmaGy7Ua7uILpm8ZtB0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E6UwMOqOOwrd7V6c+sv/kvPqbrrw9njwi7hwLQN4u6L0J6fiUGIH+56fJfVjT7JMMRj0VtRsH17NnhOTXrbcdq9u2InLIrd+xykRnLvUMZdkClWXNdT34a1HVyK7+BvJhcaybbGwOORj3nw4rFLo4Ncfykfi5ywYGQP8EEOslLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=K2mh6NCZ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1733724630; x=1734329430; i=quwenruo.btrfs@gmx.com;
	bh=JxIz3xo3XNbFBA5s9+qIFcHC7I8ibyJWXH0h1WIWaMI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=K2mh6NCZeBvOqmhYon7ECtHR3Vcj1/pfV1RbZODRSCMmuDDAhWXwHrm7g8mwFMGK
	 OVmdy+PwUwRTgDMucdet5VtDGGCe8MGOROTX4isEoFhIs1LIoHDl+sKF0fJEXe7L6
	 0R7u7rYgtwDBlE6JRRfB6+uJonq0rwAi1iSOqqBcUez1GK66e+9YuZAy+vig08yTg
	 SKF3T+BMsSoGRrWgI+zElMjkdMsoI2eSFxMBayDrmKWWcVRmHvqUeJCYwpdumu4/8
	 z3mI/xUQVnwRf38EwGNEJyQW8/gBYpcQ43FYQX6tGxc+a1hV/oxc2FZgLqKncOMWo
	 2ee757J6rRHDG6EJmQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MgNh1-1tq1u645B1-00mVv6; Mon, 09
 Dec 2024 07:10:30 +0100
Message-ID: <dab7d7e2-0bcc-4cef-960a-8eb58885834a@gmx.com>
Date: Mon, 9 Dec 2024 16:40:27 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHi 0/6] reduce boilerplate code within btrfs
To: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>,
 linux-btrfs@vger.kernel.org
References: <cover.1733695544.git.beckerlee3@gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <cover.1733695544.git.beckerlee3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tkulvjTDkUC8nFpWIHbH13a9ihaSsat4wd57vXlRrUg1Ix3xo15
 XzB/ttT7ApsTNp61MoT0LH/Ys+2syqlNuNw98aXnnooPptJDg7OY95HPDkd1veLGoZGKOJ7
 pO/xZfz77APUfBLILPvvB9YDvIUDCmNFqlZzRHA2UCyvr7NEclDTgvD61w4ETcfW5JcWwPd
 gYjDNkA4T0KSiNAnDH3qQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3ITJryLsk2M=;e8QBM2ToFyG7ECLYvQPEVzzOI8j
 ZGGMOF+zvwKooVST99lh1O7kiv3E7fIvK+bLlt7Nc/fKhO5rl8SfMb5zhToUXRurYUBFHhBz3
 ubes8i9RoaCvVuQopvR6xp7udE12Z2z0262Z1jCj44FeS7jDlFKC3QPiirrsnJyN8MV/gwxgR
 XiqzC/eGfZEjs6wqTrh4p8yD6A3SrA18mKQK5KDcOjYwp0pqGQiU5qYC+uc26MD1iJu9Vjm1B
 g91g1SwJ4DhMl7AJ+2o1CGu2+vFl4tT4F11kvy1EiMCkvYft3erpdKXPRdSR29jLemBGYp5oN
 l9c5n9dzUC9rKmgh68u94YMa1180WTuKfslaBxcoLBRN2oYmWHQ+MDjq1LaQA1+tWWcR4EQgn
 I3yydzV3z05akFFJoHSVt0TijaIxz0b4AbTJKjNCzEl6y1AeGRMXWq3uxtjdT4Nb8vQ5maTPr
 s6hbvMIlYIGU8oLg9/tih2zW1GD4MpVxwLZyifSS9AxTaIZ7DhggEEWsEJUL/wAb2TY/y4hS8
 KAMU8D8O6ffSHN/JpHI1V/xf/u40p6yiwveCaqs+TQ9PBgIix0ke7J1NksqYu2vADYGanPR7V
 ea7ZlVq8kzkT2luRpatexF5yEdPHxMEAMMEN1Jr/sa/OGXrUa4WoPt68QGjhqvAQQVL3vfvbN
 TmMK9ypInMUAKLZxRS8gOdxPqt73zZnzptiu2rIfy9K2xCodyQHJcNlhiCD2b/rEuzN6m29lF
 5wSpe8yPmKHo6MVk7qUv7qdVyJujOmODz93Ld7tdELb4HtHRh4adH/rEu9RFwfqgiCH7ogSsP
 TSgXphYZK9NMpgQlsFRxN1HW1YVeAiVAHkj5NpT9SSoWzEPU6/cJvUPAZpvSGxt7dInDF+sEg
 IdRV71LO0BVjFsNet+ZCGnPWazjvF3H1aPdZkPY8K3NZOkiy1to1oKyhliW5pzzJLuUJjlPws
 vfv1I8u27t0KvJAB1ITSRcZ8jc4sDLZPxnXmka/KGi1EFnm4E43Cj5xEpzDUIhCwk6WQKimS3
 lNFVfcf8++98/QRlC1NdDP5h086jpA4AfUJCTNXXVREd9b5s9arBwvaseWTMiqugQL6ijr8FS
 UF1CSanRCZsJt38k6gP2Kp1TlvzpqT



=E5=9C=A8 2024/12/9 09:07, Roger L. Beckermeyer III =E5=86=99=E9=81=93:
> The goal of this patch series is to reduce boilerplate code
> within btrfs. To accomplish this rb_find_add_cached() was added
> to linux/include/rbtree.h. Any replaceable functions were then
> replaced within btrfs.

Please format the patchset into a series.
By default git-format-patch will make them into a series.

Your current way makes every patch into a dedicate one without proper
sequence, thus LKP is reporting tons of errors.


And I'm not sure if you're the one submitting PR in the btrfs/linux projec=
t.
If so, please do not, currently the PR is mostly for CI purposes.

Please check the btrfs workflow project to get familiar with the btrfs
workflow:

https://github.com/btrfs/btrfs-workflow


Finally, if you're the author, please drop your self-reviewed-by, it
makes no sense, nor the tested-by tags.
Every patch submitted to the ML should be at least tested with a fstests
run.

Thanks,
Qu

>
> Roger L. Beckermeyer III (6):
>    rbtree: add rb_find_add_cached() to rbtree.h
>    btrfs: edit btrfs_add_block_group_cache() to use rb helper
>    btrfs: edit prelim_ref_insert() to use rb helpers
>    btrfs: edit __btrfs_add_delayed_item() to use rb helper
>    btrfs: edit btrfs_add_chunk_map() to use rb helpers
>    btrfs: edits tree_insert() to use rb helpers
>
>   fs/btrfs/backref.c       | 71 ++++++++++++++++++++--------------------
>   fs/btrfs/block-group.c   | 40 ++++++++++------------
>   fs/btrfs/delayed-inode.c | 40 +++++++++-------------
>   fs/btrfs/delayed-ref.c   | 43 ++++++++++++------------
>   fs/btrfs/volumes.c       | 39 ++++++++++------------
>   include/linux/rbtree.h   | 37 +++++++++++++++++++++
>   6 files changed, 145 insertions(+), 125 deletions(-)
>


