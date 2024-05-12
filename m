Return-Path: <linux-btrfs+bounces-4924-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195488C37BF
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 May 2024 19:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33FA51C203B9
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 May 2024 17:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE104CB2E;
	Sun, 12 May 2024 17:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rtE3SYAt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DaKO2nrT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109CB36122
	for <linux-btrfs@vger.kernel.org>; Sun, 12 May 2024 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715534500; cv=fail; b=Xw2WgmmZCWWjPNR8EjrpzuPNoUQjqRyC+ZHCZ/i2oij66r0bqHl2GYUYNQBsFqpOQWTezGBTgYG/bk7J1gSHbHZoTj9B4PuPxtJGe57d55111KE/5huD37lb14pmN7J1A+e/PMk0xBDjauCWrBrBFAMlvRMPS2yZaSCQrtV7shw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715534500; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qsj7kDX4ZxgmSf+zQ4EQk1Zgpef6Acdp7y/rrQdSf10cSXiHzpv6Onaax/wqBsQJSh3Mp5CnJWRGP15zJLWXNv46KfrAyZXj+8SWdUazcBPCAAptB6uk2AZ0sZVT32Y2sWPqqki4/RjDzFmtFtc67hGdKS61nIBJZcDrKS6ntXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rtE3SYAt; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=DaKO2nrT; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715534499; x=1747070499;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=rtE3SYAtKDX6XjT09Uj12gWS5ns55LA+jxdnLAxM5rBCrmFIkLw/Fapg
   IWYblF6/YGhnm5K/20elovdUTAoHNfUzTgi8K2cLX7qp8sY49lLXm58jf
   imTFEONVt3utOqEk/ezTgkZaB3AIJksW+p3++mTqlU2OdcPMchwXcWOGp
   EbUQMLkQk+0/BcshWQTTP0VvqjZzmps6QjS/YhKaV4TNVzhDj/bdYviva
   TJwKogXvQWMgyc6T/gkg/JmZblhwLUJIf/pIpYBrj322Pc8yGnVRNSj+s
   E6ldAyHawMz6m9vzEqkvO6Bsh4JRat2bvp9hsNOnQElBWRDSqJdL3s/NG
   Q==;
X-CSE-ConnectionGUID: 8vyRc3pxTjWW5TqtVRbyHA==
X-CSE-MsgGUID: IdvAIGl/Sf6a15yAp96RJw==
X-IronPort-AV: E=Sophos;i="6.08,156,1712592000"; 
   d="scan'208";a="16966404"
Received: from mail-centralusazlp17014044.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([40.93.13.44])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2024 01:21:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InF7E/DGcKkgcHwQOjH/yL3t+FseipgJ+JD40xchHTZ6P5oKdBzsOTuHQYwWOqmFDtvm4OFLQrmbSYD+fsXOgWnX4hCZxf/kp9+GC0/kexjE/4ue7nYf0S9EoWQynhkEiA1GtVlEgdVOLfc8rmoZWvfILP3FXXedZzdcyHhxtw7LwYARYGPKVg1HchYolkMvr6snb9MZtObc0+3wcINujcg9DueghvN6qTec9PZaupe5eIVwkQJfxO387aLZrKIRFPdOLct21NCjksuGP7zs65yaMnNjA9QatwG/HW8DGruGqeHZY1VH+tn6RdvFiMYjKYNem/U/BEQkMG1+WOx+uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=dRvmzrvbTYy/jNJcKW/suN9sSGjXoWjywt/xNTDcXpggMU8eoFyZ/VU9VIXZjq9MALbD0OgTTvkf8Nt49GyMGlPWEQh3qIE1+0ApgKNGcVwQlUWVdOG/TrqVeuXwbqvJ1jb06zBz54krf5/1wKSKejZRb2p21KwkRxL8OQom0ZeD0uOw9yUcUFIzx9mWx+hFpgjmfrsmasXv+SwGyaGQTnEgkAt6VOyOlFgRw9akOwb4pPHMesZ0jHjLuEiI8fEsS4BARcYU9w4QKvfxkx9OlE2VZWNvi2AoBeDxY8CbcKXNSnwdEs0YwzrrVhNE1X9ta7oTu0V4V+8YXEMkd9rOog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=DaKO2nrTAnRWPFCNP1AVtlhlDa91cojgG31/aNTTT0/aY70aiwkmoQUteVXDOP0MllRvoUJ+ffKSq7XzB/2bSfVLq9k2vWjxMQ22rFu10fDtzEitjUtbu4G5H6zHcSAY1ODqmU/DWupbZ88aitj4suarVzbhhtiYwPEUP78wzD4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB8065.namprd04.prod.outlook.com (2603:10b6:610:f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 17:21:36 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 17:21:36 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: "josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [PATCH v4 6/6] btrfs: make extent_write_locked_range() to handle
 subpage writeback correctly
Thread-Topic: [PATCH v4 6/6] btrfs: make extent_write_locked_range() to handle
 subpage writeback correctly
Thread-Index: AQHaozhhl+GjfAOdyUyWlxkE2nGt0rGT2z4A
Date: Sun, 12 May 2024 17:21:36 +0000
Message-ID: <0531e792-f498-475a-ae3f-0fb2480d27ea@wdc.com>
References: <cover.1715386434.git.wqu@suse.com>
 <05bc1dfe0d2769eb4f5e1e19fa6ecb76efe78931.1715386434.git.wqu@suse.com>
In-Reply-To:
 <05bc1dfe0d2769eb4f5e1e19fa6ecb76efe78931.1715386434.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB8065:EE_
x-ms-office365-filtering-correlation-id: ccf66881-bef4-4580-7cb8-08dc72a7fa3d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?emxKUEloMU9WNFd6b0ZwWXJYbkVpRE9kbUFJSzdDMXFFRnYzZ2VSODlpd2hr?=
 =?utf-8?B?M0RwaXRmQ3dOTDNCNnJXZm5FMVQwcHVKQXRabWpyNG9SVWk4K1lVUjFaemhJ?=
 =?utf-8?B?cDJQYm90UnFWU0VHd1JqSmUzaDNlRjBOem4zQXdlNlhySTU1RmtCbUpyaFRl?=
 =?utf-8?B?Z1l5cG5KQ1FKSzJiUndBQ29BN1dNSHVVdVVOeHhFVjVwL0NZQWhTOVBCWjlO?=
 =?utf-8?B?VWV3V2ZnSDUvUUFsVE80Yk5GaWxRVVIzelgzRUwrT3JFOXpUQ1hjcitBUEdN?=
 =?utf-8?B?aXJlWHhHeW9ibnJFanA0Njl2OWlXckRKallhd3BwWXZML2R2NjczRW5qVUhj?=
 =?utf-8?B?dHVWZ1doYmgvOElUNm0va0I4Yk4rQWFGa05JTEFEU09GNG1naVFtNzBOY1h5?=
 =?utf-8?B?QnRIMnNUdHJSWkFTYWpFR2twRjUyN1pnRmtCd3dSRUdWT3IxcUpteWMrckRK?=
 =?utf-8?B?eW12RXRRRjU2aHkvSE5mU2hRSVNzM3NLdE05R3dsUU5YN05lUi80aHdMNWp0?=
 =?utf-8?B?emcxSGIwOEVJc3doSjhyMXk2ME5xOXlGOVI1MkNDL3pvYlBjd0llQm44MXAv?=
 =?utf-8?B?SDUwZHhLNDltQ2FOSGVrS1hjOU9MTDNCdXpyZkNiaVliU09XL20xKzN5c1hl?=
 =?utf-8?B?S1dQUkh1cXJ0S0hTQW9iTEttWHdBMGNvRnhaZmtNbGJCUm1uVm5OYUg3M2xY?=
 =?utf-8?B?ejZIVEFYOVJydVh3YmhseFpSTlhOdW42R1h0bGVHWVNoU1BOcjU1WXNYUHFO?=
 =?utf-8?B?Znp1bTY3QVliUjIzbFpXWms4VEIzNTN5dWZzdHh3MFZRM3JIWkdrbGd2UmRm?=
 =?utf-8?B?elFCcTFKcjduKy9qckpHZ1lkMFh3a09HZEsyK1RDVnl5dk9wQ1JnNXM3RzYr?=
 =?utf-8?B?SjV2RzBKTS90M0tKOEE0bG5YVlV2MzdCajgwZDF4WXhkR3RIb0VlaHp2Smxm?=
 =?utf-8?B?RVoyUzVYOWxRc0IycTkrOUZoc0JOSVRvYmFzTnFJUzBGelR3WlF5MTVXWVhN?=
 =?utf-8?B?ck14aVRZME41TkdpOGFDb0N2Unpac3ZnTkt0K3JpdGk4bW8xN2FUVUNGd1BG?=
 =?utf-8?B?OGhBaFd6TzE1YVFPaXJXZVFMM2M5WUxWeURaZXVUeWFEeDd4UE0yQXNHTFZ4?=
 =?utf-8?B?d0RKYlUrT0o3eWVjOTFMVWt6UEJRamwzT2MvSDluR3lGM2l4cjJ2SGpnZ2k2?=
 =?utf-8?B?ZGs5V3VrL1htRHgySHM3RkxabGVXby9XUW5uUFdDZlJXZllIUEpDaGYxdG43?=
 =?utf-8?B?OVorUzJ1UnVFMHhkZVY5QU54Q044U2ZlUFNmVCtZeTQ5WklKUU1vNTJOQ3lI?=
 =?utf-8?B?UnRueCtsNVBsSnpYUGFsVlRhSkVUUmJoUE94R1kydUt4bU40WjB0dmIxQmFi?=
 =?utf-8?B?M3lYWkNaeTVzZjR6WElkQ3VhS2V0TUtoYTRJOUo4c3dvZXY3WnhEazBydmd4?=
 =?utf-8?B?V2FjbXRUckZmekQxaWZzSmhlbU5zMnhTVk1WZGlxY3RJT29IV2tZZ2IvM1ZN?=
 =?utf-8?B?ZTBHeGpiMEJYNFlwNGdKaWJpbjVaUjhWYUNadXFsQWQxMS96NXRVNEZObGR1?=
 =?utf-8?B?VWxJRXdpdk9xNDJlemhHUWcxNzJjeVh6MkJvR3NVOVVRT1oySkNxQ3RnelNi?=
 =?utf-8?B?ZEtXeXJ3d0JOMVBmL3BtbUhOYTVPZEltRXEyS2FzemNwc1FWcnp0YlBjVmxk?=
 =?utf-8?B?Z2plcHZOQk90dGhCUzFjQTMzUk1ERVhpWEZvYURKWUt3ZEZTWkl0NnNMMEU4?=
 =?utf-8?B?cFJiT3lZaW1TR0NSTTBzVHZkdW5XY3ZFWUwxc2hKZzFZNGQzcTRkZWdnU0Yy?=
 =?utf-8?B?cXo0QmFZTjQwZm0zVitRUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NEVBSzA4eXUzMmtBUlYyZ3hCSEU4dTdwcmhxRVlOZ1YwUlNPMkpRUXR4NnRO?=
 =?utf-8?B?T0U3b1ZVdWpYTWV2SWNxYk11RklvcytGQkRLMEtQZU4weCtXa2pHZW45MUNV?=
 =?utf-8?B?V3JRNDJvRndSMSsyekxhZDV2N29lRmViaTgwbEVWai9ZTnR1bENYWXhzRG1a?=
 =?utf-8?B?Um56Nkp1TVoyMmtOZUlFQ0NoUzNUN2U1Q0FmWGxoY0RySTcyTWE1d1h5NGx5?=
 =?utf-8?B?SE5vdGtxcWlGQzNCM0MvbGlKMUNmdUJhMFFMQzhyTXRJSldjVVR6UzFSZS90?=
 =?utf-8?B?aGM0N3RPTS9yZDhkYlo4ZzZpdG1VZG1XbW9oWjJ6WWhVampxcUVpb3VaQWVC?=
 =?utf-8?B?a2pUMWk4NVJOc3g0K0VvYVdGT0VKa2kwdEN1QkFzUXBIRmdlSlZ1RGlva3pJ?=
 =?utf-8?B?b0ZubjA4NGhuSndTbXpkUlBrdVRLNnlNMFNBMCtaZjhtdVVQNWRYSGRMR2ZT?=
 =?utf-8?B?alQ0Wkd5c2VCekoxREFxYzE5Z0I5ejFYaW5qMWNhREpnVHdoMG8zQ2NiaENE?=
 =?utf-8?B?cEdBbEFTYjJ3OURWdU5ZRmlXcFZiL2djcmpldU5iajE0ek95L2hmTE5CeXhW?=
 =?utf-8?B?N2JETm0zQ001M2lFZU9HNXRGOEJqb0c5Z0pHZThHOU1CcWMwdVZUZ092czJX?=
 =?utf-8?B?UFBaYzEzVDNLSzRTWnB6anNVZlVGSHQxZ1VJYmgybEdhU1BXQlBnbFNJR0E5?=
 =?utf-8?B?WlhrbEdlWUlVanFWTVpUZXNValNWVjNZOFpraWdXT0w2VllqOHRzUWU5SkR3?=
 =?utf-8?B?VFJjL2RRUUJMY2FRY3FyUHg4TkdGZURVbTNLYkxsOHYzVG0wZ29EajVRTll0?=
 =?utf-8?B?ZzRPelA3UXhrc3BUTkVpTkp2KzN2Yjc4bkhMeEFSQ0I3ZDFseERkMjhoc01P?=
 =?utf-8?B?QThTbzc5b1kwc2hyaUZ2OEdNNGFoQlcyOHJNOGJlMUNabDkrQzh6a0dHby93?=
 =?utf-8?B?Q0c3Uk5tWWErd0VkcjlMVFFkdStPQWxuV3dMR3ViZTVzVDU2YWFQWDJNM09T?=
 =?utf-8?B?NmtiMmdyTHFKRXVFbC9XNmYySmFsdHB5NURKU3JCZGRkOVp1djlITEdVYXVJ?=
 =?utf-8?B?bEw4WFVsL01nSi9hcHFoQTJPVk9sZGwvZ0dBaEJUQXJDWHF3RWtPVTIyUEdX?=
 =?utf-8?B?M0V1Z1B0TVFXekdjRXdNOWU5andOU1VUK28vNlNVYXhOY0pBeFcwTDFxVS91?=
 =?utf-8?B?TG1TZnowdUxsbTdrWVVvWlNvTHo3M3RnSlk0YVdxTURYWE1WelBtcGVGcENP?=
 =?utf-8?B?aG9KSEdEUmhpMzdKc05VKy83Z2pOTmMxZEZ3QVlBK3gwQnZJMUk0eGFxK3Bj?=
 =?utf-8?B?RTFLaURMdDVXVXFVc2wzRXNDTHljaWxxMXBsdjkzZXpNenJqeWsrMkJHMTJp?=
 =?utf-8?B?b21iTFRBeDltREs3V1crSCtCNE5wMFFWYzd0WDRGVHk5d0lCc01OOWtwS1lo?=
 =?utf-8?B?dlFvL241RmovdGp0VnA4ZCtpa0lLY1AyWTRpWC9BL2tQM0lrS3ZVeGJQVTY2?=
 =?utf-8?B?KzNMUEdjZGpOeGI0YlBNYmkweU9uVnp0cG50YlhaMExtM0JWM01HczBGSnhh?=
 =?utf-8?B?QlFuamE2RWYwYUhVN2RuZ0dBOUliMCt0UHBNYitQcnlkd0JCTTJOZmNpWm9q?=
 =?utf-8?B?dGQzWHZqVUh6WHZxSFB4dHBoMlZvMEpSVE4wSDlXUThXbmRLL1VzVU5DczFa?=
 =?utf-8?B?dGhwREdnM1Vqc1g1bzh6dExPMXIwYm5EUUZvVkh1OHNtU3llMXlDRkpYTXd2?=
 =?utf-8?B?SmF3cjNnL1lyS0pGYk9iUm9vZlhJT0kxUkJjTWlMdVBTNEVoZnMrQnhKNEFG?=
 =?utf-8?B?VEEzWW9ObE1zclptTG1qTldJd1Bzc1grY0RwQTUzUWtla2VFR01UM1dldTUz?=
 =?utf-8?B?RXRIcHBTODJYTCtkVHN6Y1VrMEwyM2xjbWhvb2gyWHR5dzFyQlVTSTh3N1ZE?=
 =?utf-8?B?eEZIdjh2MWNBWGxhUWdzdEFBQnZnVDUyS3V6R0dRdnFsSG9HTnBZNkFvNDJo?=
 =?utf-8?B?bnpxV01wUFBlU2ZCYmdXdG9mNWxaV0RPeXY2WWJYY2RLYVFOa1AzdFhXU1Z1?=
 =?utf-8?B?aHZ6K2Z5Qi9PQ1RZZHFIN3Z4Z2JXUmJTMGpNUlc0Z1A1RnFyanFMTm80RllG?=
 =?utf-8?B?NGdmeDgrczQrZVFEQnpveTMzYXdJWThDSDZWUzFaNWFOS0dFTnpncGlLZ0JZ?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B97518CF3988A346859473EB0B58BFE8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8JY/BLzKZTfgfz2y0ToLaeRBR3ZTwC09lyNbCTWqUzC06J4B9TTu8DGRG5NJvRhqnY0bLQmDBqQsc3JpUdL9iKHo2Y5H5wKx5sh7emAfoAAwEEybpsJaZXPlovXuevj95MamW4sv0cRB6XP6N37T1GyKYpX7JXq52g65OASQy79nbPAKE4TDEXwb9GOr1vyWcsyA79r6Qxszr8FwKw/RfMrgTGkNem3m5IznzGK6lCIbSyg1iPdGmc+LOHR7FMB3+pay0Fy9aKBBAXVPbVogCf1pa9pSJIy/FvEk+5Khtu9VX4JWybBOzld9XIy/45alIZt1xZnJeej/M1FLqJvU8xE+lU6T/AOVl+AmA84MtDwZNfOssFayu4GSiSysPQCYyprDx99xSuJPMQK6PI5o/bl59wurh6tfOv6xDt9CNzowiGdpUw5Py2qh5qhKrcn0sZOmhCRJyxb2dw8sLW/uBzrHXR7a0TgEmlgA0ShGhF5GqtzBH1jqFfoP2H7GyRhNTGt9FXyHObIosTkizgx5MT6KNrqkUYa4+g7CMEzOJzYe0cb9YntITN7ulUnHw4eNKxaEWAFXgVDs4lBt1VJgiRrJlgDRMgUXRpEyL23kzs0ocxiJfpjKnDYXbDw7UfKV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf66881-bef4-4580-7cb8-08dc72a7fa3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2024 17:21:36.3074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oPB/cJxeqpFhk5mkTBnC40ena0QMFT46fRbBENmm+DGxSXoe1ZlSGMO84b7+07bpoMq2hjSqleBHs+0LluiLyyTT92lN2TSVyre6IINyuk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8065

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

