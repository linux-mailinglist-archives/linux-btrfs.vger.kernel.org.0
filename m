Return-Path: <linux-btrfs+bounces-5460-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCE98FC4A3
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 09:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C229E1C20D18
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 07:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C0C169381;
	Wed,  5 Jun 2024 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nCpyAVGr";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="C4QqMtqG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1732138C
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Jun 2024 07:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717572910; cv=fail; b=dgM5KeZvK0ZHVewPTahjhDLSspxoCz7mNwztj4kDgbZ3AE42uQyKae/tPFyyIro3bNa97H0Dza9Q6n4TJJZ8PaOUpfKxrPAz12tUlp0R2D3WHy5MGa93nHg27M8icsMdZ1fXs/eVFF4UpyPNX62y6Q7OYnJ0WfcHQskZPfwH7Io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717572910; c=relaxed/simple;
	bh=277knVkKL7amXutQGOT2rrp9qJ/WuCQx+avLHszybuQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ANzk3NVuX83d8QciyXunIolMi4xfNuZD3FfbI/CTTK8cEITvI3qMymQ7ko1PuLPPoFUZX1JkLaX+m1fer/zT6J8oyzT9lyBif7LPs9NkY68F1Jd88+jZsMlwaDyYCYy5JbzARQkCZmZaYjmcy2kBYRVajc3CfvtcRGg8MFEw9TA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nCpyAVGr; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=C4QqMtqG; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1717572908; x=1749108908;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=277knVkKL7amXutQGOT2rrp9qJ/WuCQx+avLHszybuQ=;
  b=nCpyAVGr41x0LYUcyfeLHOxA0kk5pfrtGp0SL0h+TdDWvfJFiWy3E5rt
   qbBA9zWcGDZf47TKKmRzGn05ex+rlDYv5C57jEtPiep2Z4G2VFJyEzdO0
   OeuGPaIFIUSihyPNGqYCvTTVTizg/xIcVgYLa+YSwtnzukxTjX9i5hFvT
   5ECqf0tFKD6mIf14MkGwiJMD8qiDHzeCzbxWPlARS8/wBQJVJ1/OcuUkP
   wuoYKZi3tdn0LojZpNYQ2Kw3HYNp8FUsu0ibzwalk7H2PT8S/rCQOlyQT
   PS8aXA0VlrRuLgXhL9amJLjErzjvU+kBDWr5tv5hYM6fNPem7+iUdrRWA
   g==;
X-CSE-ConnectionGUID: 0bYpFmVpTWG7Ek5rqkCIng==
X-CSE-MsgGUID: I3ax38sAT/a469CjxX9xww==
X-IronPort-AV: E=Sophos;i="6.08,216,1712592000"; 
   d="scan'208";a="18285310"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2024 15:35:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xqe+mHxd9JvRY53gw7kX0lj4lQi3zNEOx73j49sjJ0lYFYCc92itIaE/SzEpPbhC1nt7M9QtZ5LCg6QT9VXhWyMidl7bBhK0EOkxh6Mj92xFLXvsJpzw17NG4tQSsF35/574Gp1oJljAARimjgBDEIHYmH2jFkG0x+v4DarDy3GY25nutCQ4bWx4PAsnlLKc9QUSHPc5c+Y79rzZpGjS2vjZMDPNMtBfH5nC8SBhcFQzFrEaFS9m4DogywqrBrNLCSXJq2f+zFllCILpcCnjmTJAXrlBQxDOy4xHZiI6yeHfJX/tXbxxF5da/jiy7QfA+TARjgAPyvdcfkJ+tb+9dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=277knVkKL7amXutQGOT2rrp9qJ/WuCQx+avLHszybuQ=;
 b=jcx1EdIVXb7C0/G0aifS9cOusIszokRHkMsaZ0ZRmGa5d5FkCI7Wm8ingw9i6IwD5rXIc0pEUG9UdTUZaX8JiJxpGWiDLGBr+f53PxFTnvQGqzWYILgyO3B0//hUYyBd+r3cmZ6H+V5DtCljJ/8kvA82MbOEdJAcgBo/kyqZ/0FFegiSSrk/nTJNeuZdH24Hbv8J/YUt5BUKU3DWLyIcd6i/ofCvmPVPmdSFI2KJkMk6mtzW87bZLPOdOhkai/nP57IfucLvYv9zzKkHbtJFN6Ma9zxpeodys/kAQYQzfiDhZWc5SCFkQ/r7P/XRC8OEggHCppwsOWPyzDj8BuOmjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=277knVkKL7amXutQGOT2rrp9qJ/WuCQx+avLHszybuQ=;
 b=C4QqMtqG/Vfn3ieGpWG/krg0j/kY8qN1wDsCu18NfkvL2Ph1ZdnU5mpenjAZdAc7sRetNCisjyy1VVJNHy4UGD843Wj8bZPCOqFZ7CJdncv7fiUAA0Sauhm6YiutY1u4G7jR+2073sXCNArVJJTCexdHAkFafBWpZCOK10BgUrg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB6596.namprd04.prod.outlook.com (2603:10b6:208:1cf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 07:35:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 07:35:05 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/6] btrfs: some tweaks and cleanups around ordered
 extents
Thread-Topic: [PATCH 0/6] btrfs: some tweaks and cleanups around ordered
 extents
Thread-Index: AQHatm+f+OG1XUOMR0yD2e4kKh/8nLG4yOMA
Date: Wed, 5 Jun 2024 07:35:04 +0000
Message-ID: <16a700d5-d7ba-4327-8e9c-e0496db1f1a0@wdc.com>
References: <cover.1717495660.git.fdmanana@suse.com>
In-Reply-To: <cover.1717495660.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL0PR04MB6596:EE_
x-ms-office365-filtering-correlation-id: b22bc5a1-a82c-4385-b722-08dc85320485
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?YzNyZWRkQzJDRnVSZEtEd2QrSjQ3d0cwKzExU1FuZTF2cFJOMUNMYkJFMlZI?=
 =?utf-8?B?SnhoUXdkdFZrOXBqT2c0Umt3aHcxQ05YK2dJQ0lFMlliQy9aS1VhWWlGRTEx?=
 =?utf-8?B?QWV0YjVFeDZtM1B0N2pxbHNNM0ZNMnFpbVQ0WnRMdlQwNG9pK2N2aWZrK3RY?=
 =?utf-8?B?cVVXNnZ5SzFRWVdVS29hdlZXZ3Y3aEFnKysxbFp6dHRCbDU3Zk5nRXFUWldy?=
 =?utf-8?B?bHlHSzZXZ2IwZ2kyUlVlcDdwOWZmU1ZGbDZEL3NHVDlRemhQeTVEdDZpL0NN?=
 =?utf-8?B?WXpYSUFZdjZ4ZjU2c3VZQjVWcHVwRnE2ZjVjNkMyVy9uSjQvTEFEK1J4Tmd4?=
 =?utf-8?B?SVFIcXZRaXJhVElLUWcwaEE5RlA0S3hjT1VwMVFibktLdFNCeHhPalNCTnAz?=
 =?utf-8?B?SWdPUWxCbWJwNkZjMnVDMS9OT3JLVEV3Tm5YNWJuWDQyaG81T1MxeFZ1cGFX?=
 =?utf-8?B?VEUzeVFxOWpTeFlXeU8wWHZiU1hNaGNpYmpwVjEydjR1d2dTYkVQZnJBYm5X?=
 =?utf-8?B?Y2t4WmxGWENvM3plKzdZb0RxRlBpdFVrK0o4c2h5dllpMkZKNjFsRk92QUtB?=
 =?utf-8?B?M0dYMDFZYXJhZEJpb2xJeHFjQmx1SURQSlJtR3BUeXI3THNFWGFFU2pIcTgz?=
 =?utf-8?B?bGYzU2dKVFhFRHR6N0EzRW9MQ0V6MjhtSFhCSndwSU1PcmxTMERoV29ORGNB?=
 =?utf-8?B?L1NCeGNpWUY0d1BnQWxrUnNTb2NvSVVyRHB6MGtRSnVNNk8rNFdyYVdsSnRI?=
 =?utf-8?B?WDhhSVkwZHBOa1NwOXgxUTgvNTFSS3h4NFhmc1puWkd1VXB1Ri9SQlYydm9q?=
 =?utf-8?B?RzVzUzNTRzFjajV0cFNoV0tRc1Fqbk1qcmlqMTFORGRPNUlvSnRrQW1LdGZM?=
 =?utf-8?B?bGVHVEFYQkpWTTBvQ0xmdlhFL3dOK3N5TGFlVFlCS0JpN3EwTm9BYUtQTUlm?=
 =?utf-8?B?ejFhUlRkOGxjSFAwQmwvTUpwZVR2VnlYd3NCanhleWM2Vlc4NEVKcmd2eDNm?=
 =?utf-8?B?NFFsUXNKNUs2ZU04MTlyc0ZjQndkc0hNTkh5MDRvbTZxZWZJU0J4cWZ0NDAx?=
 =?utf-8?B?Z2Z2TEwrYnN3TTZMYUZoY0duU0w4bkduV09TMm83UDNjSitkc1RMdEcyTjdk?=
 =?utf-8?B?clZuUDF2SC9CbURzT2svS1czcmMzZm96VWhFc3VKcDdxbGlIQWR3UnNzejQz?=
 =?utf-8?B?YWJsclJzSUg0V0dpL3owcWgrNm44dWYwaXZvOWpqQnVKcEYxQzV3RzFxRFNs?=
 =?utf-8?B?aU5nSjR6dGFJRFhDNkRqWnNITytxT0ExRE1XQXh2V0ZyTElKVmNXMVd5QzlN?=
 =?utf-8?B?M3Z3TGN3Ri9ObUh5SWhhYmNBeGJTU2p2ZkJXQTkzTEV5MktGYmNuM0tTaVd3?=
 =?utf-8?B?Tk9vNHNkNHBmVWsycUpjbEFjejVqbXZaMWtsM1dRYXJ6T0JqN2wvRXB5UlhZ?=
 =?utf-8?B?NmlraThKS0ZacFNJemFxTkxGMldwM0NpZ2JVbGh4ekt5OTJSQmVIVkVWSlpY?=
 =?utf-8?B?dXB0WVIzVUl0U2FsMUVGZG9EbWtaekNoL2JwVGVKM21vdm94bTNOb3ZjV1Fq?=
 =?utf-8?B?ckFQTmRBemplQWJsckNhV2lySlFocUFkSE9WVHlLcFpVNEhVNW1PcitoRDhw?=
 =?utf-8?B?dmllTDRBR2pzYkl1OHFndTFpaC9wbENFVEZFSkdYdnFIdWtKOENVSVBqckdv?=
 =?utf-8?B?SUhGajdGQWMzWDQ0SFlUN0IvTFJia1lFRGJ6bFVvdTBTSHdLdld1N1J1TFhP?=
 =?utf-8?B?enBlazV5NjVBdkhiTzBCU3A0dUcxR3hpaWpwREdpYlVaT3I4UlZJVmJjR091?=
 =?utf-8?B?SEVIWVRyS3FaYmRXRzZEUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SlhFQmV6MVY2SzNCNnErcUI3RFpLVVowYUpoZUJrbHZuaWttRzVXclhNU2pl?=
 =?utf-8?B?NFNEczlRYzB6Q2NYamFRTURySWZzTnQ2dzEzR2piemt1ZnpnWkFFQzZyQ21Y?=
 =?utf-8?B?eG9mamZ5WnlRU0tBMFQydVFkYk5NZUI5RUdTTnJzUHIydTNSMUJzbktHWjFF?=
 =?utf-8?B?d1RGQldvUUJVYXRJTG5FWkV0WWU5TzlqS2NJMm4yQlREYloyNTMxU0pwbEs5?=
 =?utf-8?B?c3VnWTE3QTBDcG53Qm8zaytuc2ZiRUZRMkI4MEFCcGR0QUFLQllMNHczTDQ0?=
 =?utf-8?B?U2R2NHMzVHBPT2FZNkdld0VPM2xVTHR5SjJ0cjJncEhTVkxxVFdmVllhb2J4?=
 =?utf-8?B?UmdaOUt1NlBvZVpQelhqaFlRZEtJQ2g5bFY2NkhIVWtEanRwN21wZ3g3SXp1?=
 =?utf-8?B?eVc2QzBFOVhEVEcwaWhaeExxTWhMZ2hoQlROR3dIZ21IWTNWSFhxUnVFNHBQ?=
 =?utf-8?B?RVBLQVRzZlFMTDFYNVlZZERXRWcxV1NuSnJWZk1RUGZwMDFMbFU0Z0tUeHBu?=
 =?utf-8?B?eTdWeE5qWTErSjVaN21oWHJOMDU3ODdpUU9Fa1RBa2pmZXEzZGtiU21CWC9i?=
 =?utf-8?B?QStLZkhaYzJjb2didXhtZldCQVI0RCtsa0M0VWJxZ1VkdjVwZ0ZnTE1DdzMx?=
 =?utf-8?B?TlJJaWhmaE9rcTB1S1R4Wnh1RmFMRjlEK0RwWXJjcXY2VE8zOERZckhOOTZF?=
 =?utf-8?B?N0JRcW9tNmk2S2VkeEkzUCt4RVpBRFpwTnFhM3Z1c0diaC9rcloxNG1QQUpB?=
 =?utf-8?B?VGgzY3YrMmJiclREQVY2UzR2S0tjLzUyZitRdDFXUTR0RHRreUszdFBVbDNS?=
 =?utf-8?B?Q2VmYnMrNUw0aWFQV1plYWRidVFxempJcy9qNUYwbEhYMTFHOUJIZXlnOG42?=
 =?utf-8?B?bVVId2llTHZNbUMvaXVxcmxtTnlaZnBaODNPSTFvdUNWdkc1Q0NQZXZpdVBG?=
 =?utf-8?B?Wm1reko4VE5jNnpOUXErWWJKbEhBdDNUTDB5MEhGUXJMMGtzMFhNeUJGNFJ0?=
 =?utf-8?B?bWJZS2o4ZkcyR1lpMmt4VlFXcGJ2a0ZmWTROZ0dJK003TVhrT0dWdjQ2eXBv?=
 =?utf-8?B?bDJRcEh6ZEdXS3MyWFdIU1g1RUh4Y3dIUFNoZThkcTNGQ3cxQW50eHJ6amR4?=
 =?utf-8?B?VCt4YlB5UUZER0RHMHdYZEt3aEtCOTROcnlwMG9ZdndzTG95eHRSV1NnYTdn?=
 =?utf-8?B?Z0hBaWp0cUZHdlJLYXVnZXNTSUlxL2pkaGZXK1RpUUJvVElHVVIxT0VGQ21M?=
 =?utf-8?B?bjFMOVphUlNzWFNZdWN5bjRKM050TzlBM0l6R1p3d2xoYTdBWTNRd0t6ZGo1?=
 =?utf-8?B?Kzh6Zm5PclE3ZngzU1loN3RTdzgvTjd4QW9GcHIzdnVicTMrWm45MlV3d2hX?=
 =?utf-8?B?aHBIa3ljVHRQQW5IVXoxQUNtVGpNYVY0czNQQVIzUUhJMEZKNlMzTG9CbXli?=
 =?utf-8?B?dk1wamJjTzhCVXltL2N6Yms2WkFJRGdCOGIwTVhoeHYwWWdZWVRVWkgyRmlL?=
 =?utf-8?B?dk9mM2NhYnZabzQ0REQzaVltNXY2RGo0WjNZM05rYlB5QVhEeUF6U1VBTzlp?=
 =?utf-8?B?QjdOZzlTOGVHK29oWko1cUZCbnh1Nit1a2FrTy9oZ210MnBaT1NWQUFZWUJ3?=
 =?utf-8?B?SERVUml6ZnA3WkN6VnZZTFJZNGNkR0Nyc3FIcDNTN0RzU2hQSDEzSEVXdXV3?=
 =?utf-8?B?aVpDbm1ialBmSmVkRVNsMjhZUnVrbXZsMTRYb2tCYXBacTFDVytLRlFHUU1U?=
 =?utf-8?B?dG1vdmMwZUZzdnlJV0lLOXU4bFIrd0VNalFqaTlOeWJJc0FDOU5vWjNEbERh?=
 =?utf-8?B?c0FkWFp5U3Nic2lLMm1NdnNEWE4reFlIV2FjeEJobmdiYStmT2VhMmFqOUtT?=
 =?utf-8?B?S1hBVU0wRGZmWENQMDNVZmVRWEJtTVZxcjRLbUIwZDZYNHJOT1F5Zy92UENl?=
 =?utf-8?B?VHh0dVF2c2VIV2xyWnpPdnFuUnR5cVg1UXFzS3Y2NUV3WTR1RjgyME1vRW0z?=
 =?utf-8?B?MDByVEx6R1hUMWFONEpjR056MmRKZHZsMlZoOUNXcGNFQVRITklzcVdrc3BO?=
 =?utf-8?B?NUJOYVlLaHUrZUNPTkJnbE9mU3lsVjhJMU9YWkpCQlFVWnBxZnNrRmkyMk9p?=
 =?utf-8?B?WUtFb1lTSWx0dmNzQUx0TW1HWExqMllzdlY0RU5NWm9sWkp5dEVReDRQU1l2?=
 =?utf-8?B?S1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8B649FD55F3B94CB770DDE65D713614@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TfkYF+dVX/HwRayL3ek2tN2mATu12j5KmlYXcSsMJAMhOmoqRd+EYLn7lOf4TWV0zY0SDmusRKVCo3OrMn48naGPfHXaRG9o9ekCFWuaisFu7PVCIqfRskyiDYCM80/b5DWvzXdIVNzYtftxYjWpAbWNOfMdZL1X3ojMUY0jutaGwrGTE+6u25x+rVJx1UlZrEqrt3gVBHVstRGUUhrDvAabfRRwxtQN9o/fWpB2Knnb10bhtyhFUrV3m6VV1CCfCbknmv7NwppqPs55LMEo32QqAiCUSQrbyNw8JnNPl1jEas1otb2RDqLsY2SOn83dPqX0/j4gmFwvPaJ3GICUG7Q3hbCS5zbkmlwwy+um+5ZFAVs2DctgXUsbSgyAEzesCXfg1isoosVPY8LPTyVjr41lAxxi9bNYJ30Dh30Xh64AFtAcm1ZCOLz1m0GV+lT5PlyBOBMRoA4Eiu0BXQ1GcCBNF8vqZ0oqkEKLUernGD35BJdM1CtOZcySa7dKCZNH232dBCyKpjYObipndXcYNxpBKBN7s6eEjWvlKnLn2L362Wn4fpYCTY72BSxRpwVB2dn6j2XRKujk1af/5icbJDuNxrKrne7tCuDgD3S97Pqf9GQjSCvP2iDQD5cx6fkc
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22bc5a1-a82c-4385-b722-08dc85320485
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 07:35:05.0001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 76n+V3ji9rD0pXb0GN7zfpcy10JKqqZTnNLVc9cg0qqmqyGKC42NkBWEDl3SIuL6ueSV3o8hgJGmUN98wEymy4/1diMSEnIVq1oEZ3/vV/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6596

T24gMDQuMDYuMjQgMTM6MDksIGZkbWFuYW5hQGtlcm5lbC5vcmcgd3JvdGU6DQo+IEZyb206IEZp
bGlwZSBNYW5hbmEgPGZkbWFuYW5hQHN1c2UuY29tPg0KPiANCj4gRGV0YWlscyBpbiB0aGUgaW5k
aXZpZHVhbCBjaGFuZ2UgbG9ncy4NCj4gDQo+IEZpbGlwZSBNYW5hbmEgKDYpOg0KPiAgICBidHJm
czogcmVkdWNlIGNyaXRpY2FsIHNlY3Rpb24gYXQgYnRyZnNfd2FpdF9vcmRlcmVkX3Jvb3RzKCkN
Cj4gICAgYnRyZnM6IHJlZHVjZSBjcml0aWNhbCBzZWN0aW9uIGF0IGJ0cmZzX3dhaXRfb3JkZXJl
ZF9leHRlbnRzKCkNCj4gICAgYnRyZnM6IGFkZCBjb21tZW50IGFib3V0IGxvY2tpbmcgdG8gYnRy
ZnNfc3BsaXRfb3JkZXJlZF9leHRlbnQoKQ0KPiAgICBidHJmczogYXZvaWQgcmVtb3ZhbCBhbmQg
cmUtaW5zZXJ0aW9uIG9mIHNwbGl0IG9yZGVyZWQgZXh0ZW50DQo+ICAgIGJ0cmZzOiBtYXJrIG9y
ZGVyZWQgZXh0ZW50IGluc2VydGlvbiBmYWlsdXJlIGNoZWNrcyBhcyB1bmxpa2VseQ0KPiAgICBi
dHJmczogdXBkYXRlIHBhbmljIG1lc3NhZ2Ugd2hlbiBzcGxpdHRpbmcgb3JkZXJlZCBleHRlbnQN
Cj4gDQo+ICAgZnMvYnRyZnMvb3JkZXJlZC1kYXRhLmMgfCA1MSArKysrKysrKysrKysrKysrKysr
KysrKystLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNlcnRpb25z
KCspLCAyMSBkZWxldGlvbnMoLSkNCj4gDQoNCkZvciB0aGUgc2VyaWVzLA0KUmV2aWV3ZWQtYnk6
IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo=

