Return-Path: <linux-btrfs+bounces-22134-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VZFTJFSlpGlPnwUAu9opvQ
	(envelope-from <linux-btrfs+bounces-22134-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Mar 2026 21:45:08 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE231D1807
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Mar 2026 21:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D1333015723
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Mar 2026 20:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9E9335543;
	Sun,  1 Mar 2026 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="XHeMPnIu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5709019E839
	for <linux-btrfs@vger.kernel.org>; Sun,  1 Mar 2026 20:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772397898; cv=none; b=fFgesKVhvj/oP+mFXpBvqGqk9+ktnh2OUPeVrkQSxuRymbrxlgDmfCUPJ4VD+kTJGRCUGm4ZNm7lpG0YcagoAOpiy4bUKBvfC5nDtExhrjfRplW5k7WquoN1cXeRNwj+JtMcEMvkXOEV4uKOBMQJDjKKV7/Fy+SLd58oekNktXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772397898; c=relaxed/simple;
	bh=e5HJLZIVZADjzI85+h0LiGGEUhkVOIEAwpWxYR6CgEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yo5FFyf0T0aVEnmImxih7V9uLTlH4dzaO+FALXwSSSJYAoodOCZsp6Cvk348W4PEZcEQLOHsSFcJUhRajKbWxcBgBHNtOCLveW6ZohYpzd2kTtisMTvO9muISgR/luCtnHtiJcjyaM6D7p33tsCBJS3X+KKeS69YzUE96IxoOp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=XHeMPnIu; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1772397866; x=1773002666; i=quwenruo.btrfs@gmx.com;
	bh=2odCnorbRRQqd/RAlZhuJHkyZUqS4j1GyRD96kSRax0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XHeMPnIuMBDHh9rlY38ZBGymFDvY0pVA61uBjfK8peDyX6wrezzC8+eg/2GjmN7m
	 dGa/yXfcthYqbzAGphMi9bMzGMdzINc81rJYw3N+QW4XE4C2BDSE5upE+morOGgz/
	 SOpyZ+2Q4PGX6f4hjHIcHq/9OPKsI4JaH0tSTE5YTdlaEjvWxPred01Xos52gL7Ks
	 dQAFllhjIG79vpWERQNY2FhbHKIjUeXCcyLFF/a7LRaenjPdUOWgkGe1C4H4h7mIx
	 fDwb8is0Uj4k17A7Ud2aVcZcOQLoF78A4+CFCimRbizORHOREsKwFv/zcvOKrrxEU
	 Sa3/fqX6XBVnH3o5tA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MA7KU-1vqj6B3MWg-004g7m; Sun, 01
 Mar 2026 21:44:26 +0100
Message-ID: <f0e1b4bc-5b03-4203-9103-b5cce563c314@gmx.com>
Date: Mon, 2 Mar 2026 07:14:15 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 v2] btrfs: free path if inline extents in
 range_is_hole_in_parent()
To: kernel test robot <lkp@intel.com>, Hongbo Li <lihongbo22@huawei.com>,
 clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, wqu@suse.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, fdmanana@suse.com,
 linux-btrfs@vger.kernel.org, sashal@kernel.org
References: <20260227075219.2594937-1-lihongbo22@huawei.com>
 <202603012047.GqC1IRml-lkp@intel.com>
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
In-Reply-To: <202603012047.GqC1IRml-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jbuBEMavu8NSdo5nID3VHUxpm881w86qOzGOqmJIethbT4iH31j
 OC1UPjyGP+n+XFaTaRH0BYGRze3PBLO8DEwPvEAm8WRi8EaPLDSGMtomBuPK6mKo+fCC+Ap
 E3reYRG0GdhiEKT5Fx/rqsB94V90lu3UQ6AkdzrR6dbCF/7FkedLNCkShxF5bObpmXQbyk2
 hJG973QsyG1QNLg652orw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:N7nYG+UcJ5U=;PV7rG2sl19sVobdpkvp9D5uy0pv
 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
 BhL1QpdWJMWEp4JCh5/D9NX/2LwDl
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22134-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmx.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.com]
X-Rspamd-Queue-Id: CCE231D1807
X-Rspamd-Action: no action



=E5=9C=A8 2026/3/1 23:01, kernel test robot =E5=86=99=E9=81=93:
> Hi Hongbo,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on v7.0-rc1]

Wrong branch.

The patch has 6.6 in its subjective line, it's only for v6.6 kernel.

Thanks,
Qu

> [also build test ERROR on linus/master next-20260227]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Hongbo-Li/btrfs-f=
ree-path-if-inline-extents-in-range_is_hole_in_parent/20260227-155544
> base:   v7.0-rc1
> patch link:    https://lore.kernel.org/r/20260227075219.2594937-1-lihong=
bo22%40huawei.com
> patch subject: [PATCH 6.6 v2] btrfs: free path if inline extents in rang=
e_is_hole_in_parent()
> config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260301/2=
02603012047.GqC1IRml-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f=
0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arch=
ive/20260301/202603012047.GqC1IRml-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new ver=
sion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202603012047.GqC1IRml-lk=
p@intel.com/
>=20
> All errors (new ones prefixed by >>):
>=20
>>> fs/btrfs/send.c:6388:9: error: use of undeclared label 'out'
>      6388 |                         goto out;
>           |                              ^
>     1 error generated.
>=20
>=20
> vim +/out +6388 fs/btrfs/send.c
>=20
>    6334=09
>    6335	static int range_is_hole_in_parent(struct send_ctx *sctx,
>    6336					   const u64 start,
>    6337					   const u64 end)
>    6338	{
>    6339		BTRFS_PATH_AUTO_FREE(path);
>    6340		struct btrfs_key key;
>    6341		struct btrfs_root *root =3D sctx->parent_root;
>    6342		u64 search_start =3D start;
>    6343		int ret;
>    6344=09
>    6345		path =3D alloc_path_for_send();
>    6346		if (!path)
>    6347			return -ENOMEM;
>    6348=09
>    6349		key.objectid =3D sctx->cur_ino;
>    6350		key.type =3D BTRFS_EXTENT_DATA_KEY;
>    6351		key.offset =3D search_start;
>    6352		ret =3D btrfs_search_slot(NULL, root, &key, path, 0, 0);
>    6353		if (ret < 0)
>    6354			return ret;
>    6355		if (ret > 0 && path->slots[0] > 0)
>    6356			path->slots[0]--;
>    6357=09
>    6358		while (search_start < end) {
>    6359			struct extent_buffer *leaf =3D path->nodes[0];
>    6360			int slot =3D path->slots[0];
>    6361			struct btrfs_file_extent_item *fi;
>    6362			u64 extent_end;
>    6363=09
>    6364			if (slot >=3D btrfs_header_nritems(leaf)) {
>    6365				ret =3D btrfs_next_leaf(root, path);
>    6366				if (ret < 0)
>    6367					return ret;
>    6368				if (ret > 0)
>    6369					break;
>    6370				continue;
>    6371			}
>    6372=09
>    6373			btrfs_item_key_to_cpu(leaf, &key, slot);
>    6374			if (key.objectid < sctx->cur_ino ||
>    6375			    key.type < BTRFS_EXTENT_DATA_KEY)
>    6376				goto next;
>    6377			if (key.objectid > sctx->cur_ino ||
>    6378			    key.type > BTRFS_EXTENT_DATA_KEY ||
>    6379			    key.offset >=3D end)
>    6380				break;
>    6381=09
>    6382			fi =3D btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_ite=
m);
>    6383			extent_end =3D btrfs_file_extent_end(path);
>    6384			if (extent_end <=3D start)
>    6385				goto next;
>    6386			if (btrfs_file_extent_type(leaf, fi) =3D=3D BTRFS_FILE_EXTENT_=
INLINE) {
>    6387				ret =3D 0;
>> 6388				goto out;
>    6389			}
>    6390			if (btrfs_file_extent_disk_bytenr(leaf, fi) =3D=3D 0) {
>    6391				search_start =3D extent_end;
>    6392				goto next;
>    6393			}
>    6394			return 0;
>    6395	next:
>    6396			path->slots[0]++;
>    6397		}
>    6398		return 1;
>    6399	}
>    6400=09
>=20


