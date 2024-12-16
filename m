Return-Path: <linux-btrfs+bounces-10433-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E089F3B04
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 21:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FDAE1695EC
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 20:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95B51D5AAC;
	Mon, 16 Dec 2024 20:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bUSIRL0R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7051D5150
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 20:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381544; cv=none; b=pL6XThbN912a4sKornoCOxp6DfCUJ7PqiBRHQswLGQ7ASSfwycv83rqzcGEeyCWGNznsonkXcKSSMG9cTTtgz4zm9Wgj0v6l0OSU10ftEw+Mv7RGEPuy27lS0i4Ajp/1R43Wb9n8Q2LXJt3+w9ww9y16ndq4YSEIabCfRiKyyhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381544; c=relaxed/simple;
	bh=DAgGrpws+L+sjOwNVaAN7R2/eCKlaNzd6ksQFMOOa64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q8rxo4j+i9C6fyOIknNTISGCHI1u2jJY9ppeoSScZS/4vjkH+2dPEVClXHNfLDPq63v08MWi6ODvobJqgURGTtMeBA6nX8F1k/sqiJgEbXRenQv6OWBhyFAp0qrvHCuSaTdtzcefj6bF8iA6/NoruQv5zKhDefLYILUvs4vP6Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=bUSIRL0R; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734381538; x=1734986338; i=quwenruo.btrfs@gmx.com;
	bh=fYsn+1n9dEv+3yb1G9spWvr9BFqoexw2ZpI+Mrwhf6o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bUSIRL0R7dzRL5opUJIlgcfgd6Cq+8X2Gwedr4//kYGMfcdL9XlfqvgjL4HazXuB
	 n/ftirw7o2ExPMxlhNXrjV2xbyYsMD8XFfiWoy/IoKE6W/bIPLCz6TiyYoHs2rs9b
	 OW5i4Q9jfdW0XvvhIkL6RGCBj3WshXgu2JH0PMohHoSmhoxYhm+hbuj0VUzCNSZo4
	 rfFLP6zERBJeyOpbhRQI5wmfOjfmjEP7++srFc5qEAgAsB9ui96QrRLZg/tVcc31Z
	 w0AjiGx7joCfPuC7P4Yg+Kgg3KwnZ4V6IHvNLDnNsidNhz12INTmSbo3rF2ofpSVE
	 JDUW4Kdj6OsGQtLwTA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8GQy-1taT5t1Wtc-015Yho; Mon, 16
 Dec 2024 21:38:57 +0100
Message-ID: <2bd31b56-30a2-426a-ab84-b3caf714835e@gmx.com>
Date: Tue, 17 Dec 2024 07:08:54 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] btrfs: update btrfs_add_block_group_cache() to use
 rb helper
To: Lee Beckermeyer <beckerlee3@gmail.com>
Cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <cover.1734108739.git.beckerlee3@gmail.com>
 <e5a958037e7f03b124b66f392d20343482b65e61.1734108739.git.beckerlee3@gmail.com>
 <9e98c788-ecbd-4a9e-9d19-3adbcb439b20@gmx.com>
 <CAMNkDpC3gC0Eu5VWLbtvjgj8vj2ckxYo5CZJ_394y_rXDQ7FXg@mail.gmail.com>
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
In-Reply-To: <CAMNkDpC3gC0Eu5VWLbtvjgj8vj2ckxYo5CZJ_394y_rXDQ7FXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hqdztob0uFVsDBUUrQp7sGnktwUamuvZPkiKdKIbznYmMaO9flG
 R1a010Kv5hbh7Qk2zG0DIUNRFrIOn/n7bRrD7kqF6cufPeUewb17Rwt4Un+QmtN9Go6z297
 PonaFUqKyLaNlVaoUKS9NiS717gnvLgSHHskNlTtWiBjW7UvgAlsQfbQJjUpeajHtTIMDMY
 gcyUg3UYrXG50quI/J1Fw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CvpwW9j+C0w=;SIuqT5dxFtzD28Q75rfeHEY5XXx
 pDecSOk8udIAZhEw6UqiZi/Xwo3e4o4sX8USjkstajJiHDF4T/JBWSLF279+IwOTEwRnPAeMH
 ec29ELx7HBeSE4jpwpfuUR0XshKJXb2wa1XbbnWGtZiRNK/WSgPYrx8/UxwlzNyOqIBLto/8R
 bD+KEgYQRmLg0BNnOIOOwiSMqHz485yK7HnjFN6hNkxw25bVVLp6rearOAWzWc/JCBdRg6w8x
 4H5wmAPYz6VNPYKHBnKjaQj7c9RclzySNRU8SSeGj4imtTHhCfOlr/r3qVbaOHaaT9G+l8pq1
 GcYRWEtaPFt+yvW0MD3Tbym7JH1rdJz3cbVeA14vKT30KWODW53z/R34iRa1IaXKelLGmNtHB
 VPL6zYdkOVGYHQLFNMxnWt0BpSuo+ZIRpPpz3J6+klw/XbYQo6z75SMc0N0v4d/vY3m1kSxei
 9LNERXp3O1Ec5OhfHhNkmLgJW6CpWxuGdCwqJwtqOPIRgbpGitvx36S6Wrej4J4bxpXDHo71F
 A2lLVIvK3P0BA0Qhqo9PGvW9DKnHj93aTv7SXLf8q7JDPyxi94hdVe8Tk2E+5mFht27q//NDe
 A9wAphXlMB6BYD932DqtGD3qYlqNAPYUnCvvm1Ulo3O/4XwV405WuvRCZy69+iFqO94GFiV9e
 q1y0+1ooVhgBrXemtXsHIPSc6sy6gW02u3+DGdi08sxdpl7LaXN58YOZEMnFmABfecGi5c7Pm
 nykPduN71cLnnA2kdTpEabDS0waB5a1WPKpWMCFeaZ/tDauKMlhn1kBUgW0FU/BHX76dDmF9o
 eXOZgi4Uy8Q6bFdAN/JMrM8BCvg115eOpYok1JDCdtRT3HVR4p3TTZrEcJl2TQ5Rrf5sHV/D/
 UK+avAaSwu/Gfmf36uL3+plD9lN8CR9FFDrdZVk6S799MGjvoYZe1m8j52+D5vHiLWp/xKryQ
 7ukVcnNbCrstQ02Ed1/Hg8RuhSf9uiSHSZXZqjYqB1XjSN9i4rjBkK9F3tcpGkTdwuJiHJNSB
 lrIdqCWxYsje4wxRC9YZ2NBRaWUyU/fZqAb5AMOBfxCF9rIaW1cmWhCql+yL63PZ5UwaQmKip
 goimDnSNZdecoMf3C/8cKuQi/9UaW5



=E5=9C=A8 2024/12/17 06:51, Lee Beckermeyer =E5=86=99=E9=81=93:
>
>
> On Sun, Dec 15, 2024 at 4:23=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.co=
m
> <mailto:quwenruo.btrfs@gmx.com>> wrote:
>
>
>
>     =E5=9C=A8 2024/12/16 01:56, Roger L. Beckermeyer III =E5=86=99=E9=81=
=93:
>      > update fs/btrfs/block-group.c to use rb_find_add_cached(),
>      > also implements btrfs_bg_start_cmp() for use with
>      > rb_find_add_cached().
>      >
>      > Suggested-by: Josef Bacik <josef@toxicpanda.com
>     <mailto:josef@toxicpanda.com>>
>      > Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com
>     <mailto:beckerlee3@gmail.com>>
>      > ---
>      >=C2=A0 =C2=A0fs/btrfs/block-group.c | 41 +++++++++++++++++
>     +-----------------------
>      >=C2=A0 =C2=A01 file changed, 18 insertions(+), 23 deletions(-)
>      >
>      > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>      > index 5be029734cfa..a8d51023f7a4 100644
>      > --- a/fs/btrfs/block-group.c
>      > +++ b/fs/btrfs/block-group.c
>      > @@ -173,40 +173,35 @@ void btrfs_put_block_group(struct
>     btrfs_block_group *cache)
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0}
>      >=C2=A0 =C2=A0}
>      >
>      > +static int btrfs_bg_start_cmp(struct rb_node *new, const struct
>     rb_node *exist)
>      > +{
>      > +=C2=A0 =C2=A0 =C2=A0struct btrfs_block_group *cmp1 =3D rb_entry(=
new, struct
>     btrfs_block_group, cache_node);
>      > +=C2=A0 =C2=A0 =C2=A0const struct btrfs_block_group *cmp2 =3D rb_=
entry(exist,
>     struct btrfs_block_group, cache_node);
>      > +
>      > +=C2=A0 =C2=A0 =C2=A0if (cmp1->start < cmp2->start)
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;
>      > +=C2=A0 =C2=A0 =C2=A0if (cmp1->start > cmp2->start)
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;
>      > +=C2=A0 =C2=A0 =C2=A0return 0;
>      > +}
>      > +
>      >=C2=A0 =C2=A0/*
>      >=C2=A0 =C2=A0 * This adds the block group to the fs_info rb tree f=
or the
>     block group cache
>      >=C2=A0 =C2=A0 */
>      >=C2=A0 =C2=A0static int btrfs_add_block_group_cache(struct btrfs_f=
s_info *info,
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct =
btrfs_block_group
>     *block_group)
>      >=C2=A0 =C2=A0{
>      > -=C2=A0 =C2=A0 =C2=A0struct rb_node **p;
>      > -=C2=A0 =C2=A0 =C2=A0struct rb_node *parent =3D NULL;
>      > -=C2=A0 =C2=A0 =C2=A0struct btrfs_block_group *cache;
>      > -=C2=A0 =C2=A0 =C2=A0bool leftmost =3D true;
>      > +=C2=A0 =C2=A0 =C2=A0struct rb_node *exist;
>      >
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0ASSERT(block_group->length !=3D 0);
>      >
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0write_lock(&info->block_group_cache_loc=
k);
>      > -=C2=A0 =C2=A0 =C2=A0p =3D &info->block_group_cache_tree.rb_root.=
rb_node;
>      > -
>      > -=C2=A0 =C2=A0 =C2=A0while (*p) {
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0parent =3D *p;
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cache =3D rb_ent=
ry(parent, struct btrfs_block_group,
>     cache_node);
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (block_group-=
>start < cache->start) {
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0p =3D &(*p)->rb_left;
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (block=
_group->start > cache->start) {
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0p =3D &(*p)->rb_right;
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0leftmost =3D false;
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0write_unlock(&info->block_group_cache_lock);
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return -EEXIST;
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>      > -=C2=A0 =C2=A0 =C2=A0}
>      > -
>      > -=C2=A0 =C2=A0 =C2=A0rb_link_node(&block_group->cache_node, paren=
t, p);
>      > -=C2=A0 =C2=A0 =C2=A0rb_insert_color_cached(&block_group->cache_n=
ode,
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &info->block_group_cache_tree,
>     leftmost);
>      >
>      > +=C2=A0 =C2=A0 =C2=A0exist =3D rb_find_add_cached(&block_group->c=
ache_node,
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&info->block_group_cache_tree,
>     btrfs_bg_start_cmp);
>      > +=C2=A0 =C2=A0 =C2=A0if (exist)
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0write_unlock(&in=
fo->block_group_cache_lock);
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EEXIST;
>
>     IIRC latest GCC would already warn about such indent.
>     This will cause the function to always return -EEXIST.
>
>     Thanks,
>     Qu
>
> Oof, that's what I get for not compiling it again. reran all fstests
> again just to make sure, got similar results to the first time. Want me
> to just resend the whole email chain again?

I can fix this at merge time.

Thanks,
Qu
>
>
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0write_unlock(&info->block_group_cache_l=
ock);
>      >
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>


