Return-Path: <linux-btrfs+bounces-2242-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F1F84DD45
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 10:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA550282A2E
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 09:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7226BFCA;
	Thu,  8 Feb 2024 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Qk2BGSW+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028636BB59
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707385864; cv=none; b=kDC6IUkz7l/3YHCcB/+d9na8mY59pm6Waf6piZkLGtoI9H8xOnzsr6W4EK+NHjfMcZC40grzUAKIrsc+6DFGu+Y2TauxRwwP/gzBKDuAa3Gje26AZhhegILjEpKCpmz1E3Vl2H8MxxZuYUcP4PfsEyoDPuEH7DIpTCmJqyJ95m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707385864; c=relaxed/simple;
	bh=NQTvrPUVbtvPbC+6PKtutmWeOwaUBSuY7/TdDEC35VQ=;
	h=Message-ID:Date:MIME-Version:To:References:From:Subject:
	 In-Reply-To:Content-Type; b=EM2tf2viBOCutuQDehOVRNFigc2uJ0naM1vw27/Gr4Em3LnwYPOWiM9oSLKhHtsIr3Nl97fBy/gkkIsaLPEUnoiYCwW3oLZ0cxZHigXNzuYiOiAErIsBUKHqdRYcdjVUMbkJUn6Mj4sfrlYxfxob/SCDifFfObwqSAweGTXodJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Qk2BGSW+; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707385858; x=1707990658; i=quwenruo.btrfs@gmx.com;
	bh=NQTvrPUVbtvPbC+6PKtutmWeOwaUBSuY7/TdDEC35VQ=;
	h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
	b=Qk2BGSW+kEsl8ck8Hb9/eZuz3QkAdLbR7YkLpB5cHyHOADZCy5DeZMT2rbmlxhFb
	 I5E9GkXE6fDtQwY6NkDppn6imK7YHlRSd4vNK1ySp223p9Gw8XIW+uFfm2f7l5Vgl
	 JmpYp4+yK3hwpbIYyoAKAgAjV85PWHnNy/xlM1qWe67Gwkxx9FSh0OVGz73WLqaCD
	 /3gbSL7GcZKJkLpOwS5m7jYyvcrky45fuf5GeVq3oOkLaL58W5Ce1NZ0gwn3l4a9q
	 ziTQflY4JlQh75akdMqL+HnHRpp/MGj+NevVY/HgrJw2Qj29Fcl87sx617FqPcx9N
	 ZEP/Xu+QnBN79j0Rew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MD9XF-1rh3c844kD-009CsG; Thu, 08
 Feb 2024 10:50:58 +0100
Message-ID: <80792cd4-d06e-4cb4-8db0-c40d2b551aa3@gmx.com>
Date: Thu, 8 Feb 2024 20:20:55 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1707382595.git.dsterba@suse.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
Subject: Re: [PATCH 00/14] More error handling and BUG_ON cleanups
In-Reply-To: <cover.1707382595.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yHUaLdtxM1ucRwE/DLSU36K3YZZs7DYQ8ZGLRRIkRDZ8S2K+bEC
 rCbnUpMTwMe+nCSNEkCtGAoGYwUdegfh6R8KfpAgWT3oArEuE1lcszxRxaqOoPbDPcXU52w
 zBcglNBnu9N8uI5jgKI/sLADA5nBc7En9XoB3O2pno370sjMyhOX6E0G4EiS4VgzBme/KFO
 nczyR2MbpdiutpsytS/Ng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SOPs6n8dcXw=;73nX/IzR3oJap4WZ3JFFts1k/lq
 8aBaF/dpbIreWUJHAAA8cM+zV0SynOjmmxdiC2yJsQiLptmmB7Jp9Qx16qeql0VHgb2IwAtKo
 P0CCLKzotQ7TCa9P6lcqAfFzJAH/MeIzKHKYOOsh/w6wtLUP2S7IATppE57pZ3+LvIkdn+iJs
 cktFjyoFOMSsp2DSfFhfIBN0XJfJIUtI8ga5sdDoa2abtvLVNV7qz3lW9zhsab3YOtq6D7mS2
 qwksVl+i0jUz41SIVzSkLjZLGYfm/JL06k177MoC98C5XWb0jTgCyM1mtBXD5EL+A+ZbEdciR
 y3x6j4u1yKM6K+/ljMq8CY7Gj3XnYLqh6rxoBlSxDCZqdwDTt/Q/BfG0ZCFirtEyVWnrNssgo
 XuLhbYtQC4AUvmL3zXkbNKbSwQr65trwoscACYx7ZyrASNtHxaeCU0fRw4jX8uhUWgIA8d2h/
 Gs86ZASiJ7tKqfJBq+CfE6YIqSce1XlerxuJLfuxGiQAmCeZ6Yn0pi9w6CCxPuGILuufoqeyx
 wLhJ2v33erUzU8ZSTxy4ZAfyUZhKFY8iv/PR2W3lA7ecYGCCIzklTA8d5QkBv3X3KSjDBDHtQ
 xdXs+ODLZSfXmQLYoewrUps1RdF6OAvJ0ChxVD5mjy/PcDy/1x1f/EdxmySUVAWKRHfLROHRl
 I6SLsnUlVcGFOYhoVv4x+GcZrkHibjQKjuSsmInMdgFQljNXi0kAwZ8i4A0dWO0qmQoomvzUx
 Vxmd5GgnoGpYeGJxFvq6kUnOzcPQiOOco5ZxeUGN1mc9HT0LnH+BYpJQNzXiMjQnXBwNh9lYI
 fW/VWCXl17vBHB+/EqL1FVV+e+gJUrJ92NFN5h1kwfGto=



On 2024/2/8 19:29, David Sterba wrote:
> Continuation of https://lore.kernel.org/linux-btrfs/cover.1706130791.git=
.dsterba@suse.com/
> BUG_ON converted to error handling, removed or moved.
>
> David Sterba (14):
>    btrfs: push errors up from add_async_extent()
>    btrfs: update comment and drop assertion in extent item lookup in
>      find_parent_nodes()
>    btrfs: handle invalid extent item reference found in
>      extent_from_logical()

The above ones look good to me.

>    btrfs: handle invalid extent item reference found in
>      find_first_extent_item()

For bad extent item offsets, I'm totally fine with the current -EUCLEAN
even it doesn't have any error message.
As tree-checker has already verified the extent items, thus it's way
much harder to get runtime corruption to create a -1 key.offset.


>    btrfs: handle invalid root reference found in may_destroy_subvol()

But for this, I strongly recommend a new tree-checker entry for
ROOT_REF, before returning -EUCLEAN without an error message.

>    btrfs: send: handle unexpected data in header buffer in begin_cmd()
>    btrfs: send: handle unexpected inode in header process_recorded_refs(=
)
>    btrfs: send: handle path ref underflow in header iterate_inode_ref()
>    btrfs: change BUG_ON to assertion in tree_move_down()
>    btrfs: change BUG_ONs to assertions in btrfs_qgroup_trace_subtree()
>    btrfs: delete pointless BUG_ON check on quota root in
>      btrfs_qgroup_account_extent()
>    btrfs: delete pointless BUG_ONs on extent item size

The above ones look good to me.

>    btrfs: handle unexpected parent block offset in
>      btrfs_alloc_tree_block()

For this one, I'd prefer one error message or at least something noisy
enough (aka, ASSERT()), just to make life a little easier when we
screwed up in our development environment.

Thanks,
Qu
>    btrfs: delete BUG_ON in btrfs_init_locked_inode()
>
>   fs/btrfs/backref.c     | 20 +++++++++++++++-----
>   fs/btrfs/extent-tree.c | 12 ++++++++++--
>   fs/btrfs/inode.c       | 23 ++++++++++++++++-------
>   fs/btrfs/qgroup.c      |  6 ++----
>   fs/btrfs/scrub.c       |  9 ++++++++-
>   fs/btrfs/send.c        | 27 +++++++++++++++++++++++----
>   6 files changed, 74 insertions(+), 23 deletions(-)
>

