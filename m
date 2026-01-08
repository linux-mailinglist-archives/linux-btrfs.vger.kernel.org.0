Return-Path: <linux-btrfs+bounces-20310-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 088FDD068FB
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 00:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99E52300E4FD
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jan 2026 23:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC39733A713;
	Thu,  8 Jan 2026 23:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="V1U2CvQm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A9B1A76DE
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 23:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767915824; cv=none; b=KieerHGB7Ewj+M0nUV6wqPStX8bzADG0DqJBZpRJrRhzJBq5Phrb0h64JSHB5t1hoL9Pss84h1pyYVjdHjMnC6bBq/j5LfktuOgb1dbMH8vlTHJ2/iJMHctMO2VaBXF3usGpmxd5gWLYgGBtQL3wGGIfr2jVU5+eaapnCIZOwnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767915824; c=relaxed/simple;
	bh=AS8V8UzzUzM2rj9HYDgpAGQh/3A7hjXXNF1W5/ZjOV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R2jO93zopgNXONRaDGzFumXVo9iW7cTP9ERudpe2KElBojVHuNVwJiDxnh+SnO2r8X9jOmhaXRPSd0N5eU2PakS9A4pekb/o0QDQhx4N2vFGr9K8Pi053YZReU61M1Dsod9/MdgHT9f3pwNIPZHJYggCnp9xp9Vg/yGIqJWibI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=V1U2CvQm; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1767915820; x=1768520620; i=quwenruo.btrfs@gmx.com;
	bh=lhBOggmhEISKGrBTlm5QZ4cr5QTq0pPKuCP78l452vE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=V1U2CvQmzTEgsUZ7KLpDeyfFdq7Aw1D1epUzCkMtSvxhKhMpgHhgyWAMw3rIcssu
	 6tSJWP96j3tO2pYfDbnqie9JX76rnUzJzMBp8gf5iw/SD6n/CSdyiuIRqhIbsRPJH
	 aEAH87Kzi4GIVDj3M1ixVozz3LShVIJ9nAFuaXHDjBqrMfgzj2ex+qN0wm5JKq5Wt
	 +d0YuXCX02iGpaq4XDSfV7o7qTvZZKFf2vMDTKZpZBqNK/fhkihSicjyyCi0VemtH
	 VoFTdnn2xPFaLNBJPfTf1xiHMyVPDqUO4vCF+WRDWDx2fsCV1kBVPF2RnegtkLny5
	 HGJ68AlBvcTowZqK+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N3KPg-1vnRtV483e-015TDP; Fri, 09
 Jan 2026 00:43:36 +0100
Message-ID: <086fcb06-c575-4e6e-8e0b-66c9028e635d@gmx.com>
Date: Fri, 9 Jan 2026 10:13:33 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: invalidate pages instead of truncate after
 reflinking
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <857d9448b17a3403e5c0bfa71f3defce4331f535.1767891836.git.fdmanana@suse.com>
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
In-Reply-To: <857d9448b17a3403e5c0bfa71f3defce4331f535.1767891836.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6jDoJf/TJN1p9zbvEeJk8h2jBv6ggq+IsX/gxil86mxvXDgneyD
 984CT+xH73MPKbvOhlDoGg/a8715C0pblBjr36lmAlDFGy2FBd31WYEUyQ6VIr+/pLNg5RA
 75vMwXlZud4RGstOOFYXD+HPiExfkUBYOa9MMjigB4znk3DCqTm7RbowfYxQdw4qEob6ROs
 tCLQV2X5lgbao0OslUoWw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/lE3ybuesWg=;MdkDwgDYal+eGgSVehz3gGe7PFv
 GfTteRZiZ9gNEFTODP2kVpU+cPgoC+qfbZI5bUU4f19mMSrcK9hvV9pwgOk/qGiX3l9Tk1f45
 mciSpB/3wSnI5biA7EgBEEhEzEFoBQ5wPtAakrwx8wZdma3u5pPbXnDzD3wYSVYPxSheni/rg
 d8oAjVLpFUO+6k1iScl04rLrLllsRGGPxYSiMA68pZE5BbCsHkgsDD2gk9s+r1ehMMVRLno1u
 DFk1NLEfACpC3wUszK7MQ7nXHwndhsEQrCEZjJEn92lw8ACxoJ5ojIuk+pusj+j4B95iEsz/a
 +v+Q/zR9wIJiR250L45AFszZ6qFAwmDiPMT6GzPhUc9TNEEvy34WM4xV8/LstXWTi/JoOoyP/
 t9+0P61mP/u4rcgutsdPLPBkEet3w6s1QXLzm5he01pP43/w7yoByDP4so+Tj5e9LUcVljltG
 0WLjr+NQ8GlQWC35BFfb8udeY6yxqaJhEWGTTX8rUfTBjoWuEMsuFY+M4YaSIvtEukp98sJjd
 o5WihaTnCn81GSlsx097mUMp3KoLxJL5bajzYvWyrPYALzuheUAmoppgV7SSl/LduBTFo1FX5
 2MLiL9UsWdIrn3Ab3NKCiQ4k4we9qiLlIDfsg9/igxGNEUw+JXumIdpwRcCPaok1Hju6rFug6
 eyFKy6hn3NcHET/nTn7UjW0di5WlYR0qRYOvqX0GAS+Dtt4aaGNIS6WvV2KUL1hARzbxfiQAo
 WPQAIW8hbZEuNC7xLuUFNucSe1C+RMwpVwagXtKJNHEBjNoi9Omiso9O3HLOcsL/fOM3Wgf6V
 bg+Rh/LODiie5i+lwt/W2f/H3DCaNTgkPfu3UyQmSIMCnlGyaHUZq+8aT0euQruHiYA/LAULK
 CYmLNqWsPpHXjYjCHwVV9xvClD9VeFiXpWbT3fmXc37qi1oQlGqm8B4GbcGIEpHy4y+6xCyje
 F9IOJkV5sLsCtvlutyo5laaL+ZFmtBDIBoYsTdo9Yu6pryoJdzRztJD6RB98tgO+9aHPrTaPw
 qpUz0+DctrkB7koweVxDM1r4dQt0DI4ZmPqYzswo4QNNxYHWDpuZmrwM+OnlTAwiZnEp+k61q
 xESGAKRvyc7b2NtUzdfla4djD9YeScj/0cX3jx9tRql5t/TionK+wUpRVzmIL79fKlpH0uq3v
 CbdKDVY/Vr0B1oGChe/2YKC2muUvZEdGwcf6OUr9uJccguzR1HXgcP4x5eV6d0qzVrsu/kz58
 3AqPG83dJhhl0iU5FoABCwT0cMco/a80fm9saCIJtNUGYFaEWbwpVfEfNza2auorPLpbK3zHw
 QjEgBdqaCXVQH3jw3+FqDgSXIC6lC2GFBsmWGvvtTROxLEy4XdbQ3lYQqCDulFG1bqLyx3vob
 er71QjeVt2foFG0uFjDU7GJyIzmv+R54cTcK78K97uGGDCKbOs5OsvGvODjE8V+koSYyMHKQr
 JoCch2etz5gCrGO9JCJrMTuR7SPVHRoZzKqgL/SjUitTkUtJJSbR/EM2RhupbUzp6gPTr3icB
 K57GqYF+TrOqlIK/XCCpw0cgr56teJcwr4xY4nxxnx+uE112h8OgPn8mlFB4xPWNyl6JbQAMa
 MDkFCAb7Z1k3HPcwCRho34LsedHkt78znLWaJdwH1dq1N8NQhvmXdlAE712pxn9OJU824NEeU
 R3pgan64qFQNGWLxeq6g+lzGbo5d/lOt9xisYDcf0UKlx2yg5rQr7k2+Pj1XLtmEQqsUHaAhs
 zSSxyh1+76oAzu505II6or9VkvuEbl3YWg9YO2o2oDAubiT4Qw3hlLy+gDRfL64aDLPQei6t6
 B5ENfCBwrct2yLWpLnosbFQUelz3yLy6D4Ee7zDZHQXVuEY1HMvNqhZMyrKPFP+pXsBnwM8p8
 9tYuv4u971BCYhPnsnGAeKCv78ll8eygydSas5q7M2oi5GYDO6o96+vcgqpAScKI2onPPkTdb
 sf45tTNuK36ym5dfxWUQ6nwDhsVVY4Uwij8kJ3YHeqMuQrY0UaXTqiwfxBTvGBKpxohguEP+Q
 FhYXOa3AY1hHquQz0eMXhQz47/Px36Ip4oLO+Ee/V6/qd1S3SUtMrw99i4TkNRaTGjSp3z7sz
 NeCfhpQfRH9/iw/zckIVJBgspZ77CTet0L12N8nxC8l/QycUgMB/NiTKa5taOGApFGuTa7LB7
 lF8YDm2Cv6R/1vrJamws3JrdurnbR8z/7zoIw5T4n8bKpsJV1sQVpuBJv6OFtFVBAs2dbq0eU
 6ct/fLAUwb/0bRQTYYzNa9+laPlnv1K56ZZJXUwWBWPULyGBi7MaPcSS3LxNJ+O6OiBJyylzD
 WlF+IXdI2gjgoDckM1Rivv158l4SRxZFfR8y6G87PqKhEryySiPtag0YgDZYMzwJ4pI4LL+AY
 eIWx6sFQLQZKeYt8eUkWepah1y/pumc6YKi6kwpjw0fbKOII1S5OYqgj3JhIOCM1EK1y4BnbB
 zO+SjgcQDRCd7tNkNHfruyudEhuAMTDWasSHb+qbCsSzvLqKU3lXVx3EkekkwdPHYRsmRxYux
 uQyEDP2A/BxKjQWovrH+A8/PJyEuFRYtRKQ2OM9wZplVqd1c51gtF1x5KYhER7qMHRB+cuY7a
 TeQw3b84Q4AW+HsEEoDiZRe4T6j5sT2HcQIEobpE1rQA4ONjtStV6/rp9FoFKGXoIhN+toaHu
 lfzMB9o81u0qteHvelcbzbfBf2ONI8KTJ0NZi+Pu8UnBUXiuzdzlLqTkiLQe66p/f9oegE0Fs
 ei3+75sGkQvgS3El2hvmw4RMYZHyh7+vUVxQ80WiAMYD3p7RuHEKIhOH27bNoWthV0IUDlzew
 P3lvE+WLWYtmE8E5JqWQs63xmGP734EOgW66zZt8vU1F8K4FpomR+aCSsan91ie+Re9SxknuC
 5HL2GcbApM0GXJO4bN1/TREmwBlllnDblLzFvEdZQY7DjZxcHRQN4vawzkhw7NDmTHcdniDuC
 ouZxR4oi3DpjNQSik/1atgITeSllp83DlBQIsIci7U2lx+5Np0M43DaVY6XEPjpGMwn28xmlT
 vSTStGG58yj4QWsfSVTyS7+X4e4VPJjebVzcY6oLt+odBgajwgp0UPch11VcRs2CECAs0oOx1
 cvATL9+IFUbVMqouBKysYQIolOrAI2kiS+b4apNPEZJw/3IDtxn5bFtBXfoItSWdt8FC8B8rt
 dFBMRtKf2XYwsZ9biD/gsqS0HMJ6xRxqnyWtzzJ2ojT/lOpa6G6WjueG0tRLwEAfUR5R2y4k0
 C3JY5t0fMcpap6v7peK1v/4BsaScd8vH7bLsjfmIth69fFTWng04xUMvsij9qg73pXajLQ+dY
 nNOVv7YE3QEL58l844uvyRxjG5tBrtTlU10z2mD5VP4CFK6630XO9r3SUmfnClyMDPv8XzLrP
 egtTDnRdaJBP/AM+h4Y6hUXJuWZv+dKyghL0oPUvmtQJI1SfoF/R6zUD+Vd1qe4++ieqEH7Ux
 zULVtbpHc+DcPqJRzLarfX2vgYEVTrh4S+cYHkqNk2vBTMwQmWet4+y/GTKYqfsJFkdN+2AD/
 ROPNxt3IbTE/L/9oGX7PosLgFsgzdaF/UNfQx0d9KSsstW8KreiUoLy1k8zlDuwcNuA8MVnke
 ioMwRQa0p8HH582lObD4iDtMhD40zzxcJh/btmUd2Hm6fWtHiIk1IgU4+tcNInS9/LtN12Jen
 J/us1EuGqHUPzPIHOC1hKKcNvXFTikc7PhlmSF0OS64Ek19jWitYRbkF50+gy5duzBSko+XwQ
 mukjZCtdMEBjtP0gFSb3/lZcYdjUEup+2Z7Z+kpVtQ+hCX8nxkEse6P7yLbCYaJJxuuAjxpmU
 iING+nCqF2zWz9Q9WEV0Daj4aWEKgbRTB8eNMrLfyGnSMcn4ofMYMiq1N2KzTAst5Ptlh+Ihk
 mdcrh9LX3rxQ779Jy+yEGhxxtHNBfGDuu2tg8PyfMXsm/8y8pUhYhL5kk/wD+Il04Y7jkgegI
 +SMoGPhiVUJRDZyssk7ECCpcu6RwzQcuaTPc2Ame+P9oF3/5eaj8BSBhA+JYVELYmMx1dk59/
 nn1fFj7QptkRc/3zE0cjUPXuvzdGqdXGbLbPUhH4CTh9L6/pJwZUKw5OHQJYtF3P7w9ypcIJk
 Zv6H0aKj9dBf/W7BN7xLDSQSXbuk7kUT0HchCSPS3jZIAM1byytthjET9kIK04PKx5eZ4xyZj
 xIO6PDpA6A/HoD7Ug/9exXDXS7NbSJyfLltu/g5vGPif1JKmiSbrgC3q1d6RsDFx5i/L5uJTo
 SpmPRPM5WtQvNR72tzWcYozzYcSgDIUS6gYslWfWnFXf8NpToRcDwMlDCiBWBusPz+nnnVS4S
 0zf4Yg1UjNuNBxclMIArrXDB8tqU5HAfbZcDvVBpoI4hOXQ7Ah7O444awVM1KBgquN7GA3fX9
 QrLmvxjVbKcwUqz8FU2yzg0sztfEW7oNqJrjhMdIRtfBpWuAJyj+MPWoy70KhmlOSyb4ADIp0
 PT3doX/8f/MxsvSuAlwlt/UjzgbUzBLPI/ct4qfG5WD8g5uX/H7ljWHuwrYZSHT4Dmr4CEChl
 xFfYVbnDW1WXRWnmlKv9tlaVsk91n2EUaOghnJuYBJLywCnTFuq8vgEPFnId/8vGNcJwT+NWF
 qpOBoGq3YSGofRGdF/g1RFxntXMebX4/arCQ9jBNxSSMxPNxzkVZn+WYLDj1oA8a/3X8MBviU
 chNcWjlSvwYcW4tQSwQUP2H4BG1TmaXLOKWn35IaCtySQG7NOlDIwRFLePLybhY8N58NNJgot
 NI98QsaRp8FrzDb6TT7OOfYxgzLgXt71jhoRhPZjgmHre3Z3B3ZUwLeF4zxCaEpIrkxdUJ7uT
 QOGV7lZ9KUrODCd5ys6AlxeIEi4wJha7cbKwRozKMmhNL+Amx8O43D1Oul1wI/ycE7LGZMAAK
 5Utm/Nb7GkD8Zz2DorIoDazhhCKHVkbjII9tvz4zPYrfguBaIHS24rYg1H42zqPeH



=E5=9C=A8 2026/1/9 03:40, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> Qu reported that generic/164 often fails because the read operations get
> zeroes when it expects to either get all bytes with a value of 0x61 or
> 0x62. The issue stems from truncating the pages from the page cache
> instead of invalidating, as truncating can zero page contents.
>=20
> So instead of truncating, invalidate the page cache range with a call to
> filemap_invalidate_inode(), which besides not doing any zeroing also
> ensures that while it's invalidating folios, no new folios are added.
> This helps ensure that buffered reads that happen while a reflink
> operation is in progress always get either the whole old data (the one
> before the reflink) or the whole new data, which is what generic/164
> expects.
>=20
> Reported-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu


> ---
>   fs/btrfs/reflink.c | 21 ++++++++++++---------
>   1 file changed, 12 insertions(+), 9 deletions(-)
>=20
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index e746980567da..f7ddd3765249 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -705,7 +705,6 @@ static noinline int btrfs_clone_files(struct file *f=
ile, struct file *file_src,
>   	struct inode *src =3D file_inode(file_src);
>   	struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
>   	int ret;
> -	int wb_ret;
>   	u64 len =3D olen;
>   	u64 bs =3D fs_info->sectorsize;
>   	u64 end;
> @@ -750,25 +749,29 @@ static noinline int btrfs_clone_files(struct file =
*file, struct file *file_src,
>   	btrfs_lock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cached_sta=
te);
>   	ret =3D btrfs_clone(src, inode, off, olen, len, destoff, 0);
>   	btrfs_unlock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cached_s=
tate);
> +	if (ret < 0)
> +		return ret;
>  =20
>   	/*
>   	 * We may have copied an inline extent into a page of the destination
>   	 * range, so wait for writeback to complete before truncating pages
>   	 * from the page cache. This is a rare case.
>   	 */
> -	wb_ret =3D btrfs_wait_ordered_range(BTRFS_I(inode), destoff, len);
> -	ret =3D ret ? ret : wb_ret;
> +	ret =3D btrfs_wait_ordered_range(BTRFS_I(inode), destoff, len);
> +	if (ret < 0)
> +		return ret;
> +
>   	/*
> -	 * Truncate page cache pages so that future reads will see the cloned
> -	 * data immediately and not the previous data.
> +	 * Invalidate page cache so that future reads will see the cloned data
> +	 * immediately and not the previous data.
>   	 */
> -	truncate_inode_pages_range(&inode->i_data,
> -				round_down(destoff, PAGE_SIZE),
> -				round_up(destoff + len, PAGE_SIZE) - 1);
> +	ret =3D filemap_invalidate_inode(inode, false, destoff, end);
> +	if (ret < 0)
> +		return ret;
>  =20
>   	btrfs_btree_balance_dirty(fs_info);
>  =20
> -	return ret;
> +	return 0;
>   }
>  =20
>   static int btrfs_remap_file_range_prep(struct file *file_in, loff_t po=
s_in,


