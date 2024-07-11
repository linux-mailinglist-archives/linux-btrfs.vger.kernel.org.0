Return-Path: <linux-btrfs+bounces-6370-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C73392E145
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 09:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5409B22ABF
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 07:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7640B14B94B;
	Thu, 11 Jul 2024 07:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h+Fegw2K";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wtjtkWsF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BF1D530;
	Thu, 11 Jul 2024 07:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720684285; cv=fail; b=ZPnedKu64ncm50bc66HnKGPWoC+pjJYMNwZg8rDALPtCbnILau2E0hsrRFcWp9z0kOFy9R5jeT11FQTvoO0ZHXUQkUL/qVyqBofdj7w9tZ+/4UL21BacWfZzTNm5cpShRx42cjzGjtSxEiEYmJ3r/P58znQvtyXqn9ervL18tKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720684285; c=relaxed/simple;
	bh=nvv8OTioZXvXdJoZsztmASgTaZZYiCRU2TucdonVjGw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y3k8HYNmhuFGVYKA2vOBr04cuemdbw1k1B8LScLm6Jg21GuM59Wk71k//o1A/4p8Hbq26mhkJRijUpRJjHKL/1unFDVMfzI5wyMSUZYSOFHOhJhZNECi0hUegbmWLZMUBve9FSbYx847Lldv8CGoU2ut+czpHAhbZ6axxbuKFRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=h+Fegw2K; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=wtjtkWsF; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1720684284; x=1752220284;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nvv8OTioZXvXdJoZsztmASgTaZZYiCRU2TucdonVjGw=;
  b=h+Fegw2KggtIM20+UDI3VWz4+/JcJwpDfi7opMt/HL0UNBTo9pjyAWqg
   0LBwdKScNnDsdrGE+xq7Y4jQxql9t+EmxXhgrThxrjLAjzhg1JvhuNMX8
   LV9d9qN13wZ5fGxMV2t4UCiyOv+Cx1GVJBpsSriVF5QH/tVafFlD41BTM
   7Znhv/qZ+tdlxBMiuajtNpu4fTcpGLStA/Dvs4CGxeEiftMW57Gt0KNDH
   4hSHuouKKelJcd/SqLto7DR7CkxtsKXzZ8MlhVptY1QVXKZk+ShI+z2ID
   r4R23+XnkQVhwdF8zgv2YsoE8+n7JXcyFTL7K+c4Ni5j4Cx2jIS+IFgzd
   g==;
X-CSE-ConnectionGUID: hw/Z41sHTsCTjwhyj+YbPw==
X-CSE-MsgGUID: 8STKDVEPQVKZ7cTbqTAD/w==
X-IronPort-AV: E=Sophos;i="6.09,199,1716220800"; 
   d="scan'208";a="21099970"
Received: from mail-eastusazlp17010005.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([40.93.11.5])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2024 15:51:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlC5IxtGvXW9ZajHCjDV/sLpGDFgFB6JzL6uKeWbuOekoWcuDz2srA6zuHOcCjhuTLudRNlWLcuMzdKfEvurRXUPVGVCetwy19eMt9Syn/fAaHPdeXabr0rwRQrTimp/zsc9sQkXF/vq9G5u8akwUtHR0ytfwdGir2OcOpLPPw5w0te9G32R5pnEXRJH5MDUIhAbEJY5P4EXlKLRNK4k3rm2P8PfNMAHkd8ErrAW3IUBuTg+r4I4dWB756pBz7vJQFIqKM+mNz23h1xIghVxLSLM76Oj8UoFM9Cazy/9Uw7IxLm/QFApnUeyWTkgaUw9PFBiiVd84pXO50VnDhqLpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N83XuvQWj7IwJ+L6zp4amn6ZU03JrOnFCcrNOqu5Y5s=;
 b=eRvCieTNs2EJakMHjqE8BN+HknDQFct3iV119WWevdgxvHCqJaMVTXzoGmmPqVEi81S+VEml2NqQwKjG/kJZWepnO7egjAL4CNrNESLsBVoGzL0acWM+VPrnF+UhszrnjsHZCSnHBv4H2pOBLfa2b3F6QPkWzqevIIPVx8Bd3Uz6KjkKteiLcNwSEoVYOVzDQ/SQWi8+3eVLcTQVcEuaoQ8MpWRCkaipME/EdHroZKJttHC/OoAFTHWp/6Mfb0IheAkxEVyaiHlU+RGMwYlo83zrhfwNrqlfqTo8bFxMRMK7THCVdRFXDepMxkT41tZuaE2DfhjW65+zgRAIqSvmjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N83XuvQWj7IwJ+L6zp4amn6ZU03JrOnFCcrNOqu5Y5s=;
 b=wtjtkWsFBKHuUdGRlh+NljibYRR+yFKWkUDW1sV6IYmvuR7x+DzI3ucBTcYl8HXKa5Nkz/mE2pJnQqjRt7tBG2H9pjzEAeYht1WCD/XA1Ju+3FjqrC6lOiorVTEL4zX29d0zzDfkpxPcc0mnVNFyjJU4XH0UensXdGkepaKX/9Q=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BL3PR04MB8090.namprd04.prod.outlook.com (2603:10b6:208:349::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Thu, 11 Jul
 2024 07:51:14 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%5]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 07:51:14 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <jth@kernel.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Qu Wenru <wqu@suse.com>, Filipe Manana
	<fdmanana@suse.com>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v2 2/3] btrfs: replace stripe extents
Thread-Topic: [PATCH v2 2/3] btrfs: replace stripe extents
Thread-Index: AQHa01q0NPSTOM2zOkeeTRA+9/agC7HxJ36A
Date: Thu, 11 Jul 2024 07:51:14 +0000
Message-ID: <7vy733sr4wok7pj7lpsvks3kf4jkrujycia4cnp3oh7f6nu5s4@22cba7ceiawz>
References: <20240711-b4-rst-updates-v2-0-d7b8113d88b7@kernel.org>
 <20240711-b4-rst-updates-v2-2-d7b8113d88b7@kernel.org>
In-Reply-To: <20240711-b4-rst-updates-v2-2-d7b8113d88b7@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|BL3PR04MB8090:EE_
x-ms-office365-filtering-correlation-id: 1dd6a0cc-116d-4bfa-d471-08dca17e3d1f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/FlURM7wdIWlCu+zM2GULFVtodNqWAqThtReWNu94FtZaKP7hdnOErcEdDaX?=
 =?us-ascii?Q?fqRmq8Ar4m6Ij1Om6SLbzx+f9UATab73ZkPfzLj3PGC2JcRuRMhUpVj+DEH5?=
 =?us-ascii?Q?1TYvW6KmenUuRmdsdwoxmh1Kh3R1NVJfNu0k5LAL8SyU5e4vEO4AffUiUTug?=
 =?us-ascii?Q?QQJexREswZkAZLXOZf4XTkEWpFtGTeUWMFYPoQqdlbooNRPhXHAkZKGL6WiQ?=
 =?us-ascii?Q?BlEGQiHFpz0HzOdz3MvW9sDGGRaeQpf5TUOAN1LVl3KTO+yYYWuEQiD+lLup?=
 =?us-ascii?Q?zfQyuJFwAmm0R2Dt0xG0J51ycN6Hly516ieUAoZ7QfjQV+7UGE4hQA2PgKsF?=
 =?us-ascii?Q?pl8MEVE7Vf2JJ1AJgva3QD1eRmtTSvSbGkJOhufJh7Rwq9lvbTKEEcr5AdTR?=
 =?us-ascii?Q?qQZ0zkSjsWS5m1j6qfLKVdiIZUt6mjddUyXdfaZZ1BB9QNtzr3HQywGG3jpf?=
 =?us-ascii?Q?ntBx9OQmeliu/a84QTAEpRnDgUJ7DPOVK12cwktHP4qcBmf0OGO1cIbQT03E?=
 =?us-ascii?Q?AqR3HuLEz33GBjOX96n3914xTwt76uRTBHm+l8CkVWI0pCukefivnqvUUK7P?=
 =?us-ascii?Q?PmUGDypCHlTW6RzayDyEOF/8bYRQ6Sbd7ts5g1cF8SHQ5CJrbyzb6FQ7vgBt?=
 =?us-ascii?Q?gz0pDYlIWm6JRslwJWbm10neAkfbUdkf0AwsJaAzWxTZT1ppFKVbrjErvzRt?=
 =?us-ascii?Q?g1kVfFybaC2m91tSqevENRB1YBYRraAVDhA0p5a1A8YOmbPQyuqcM4cNeWU7?=
 =?us-ascii?Q?GbfwGtAaYw91ljjy06fM5t9LIeWbZNeOHL5P02R7KUYbeC4+jUkNo44D6o5T?=
 =?us-ascii?Q?CRLcHSfOdY5Ul0RWFtpaM0UynwHE9ZGMhuMdm6j0NXJT6nPy2ntb0w9S7Taq?=
 =?us-ascii?Q?3YS04gpMZTxXn0ZPNdR9DQQ4kfudwHPDx2mTShK380Zwu2uEKPWivKE+lxo0?=
 =?us-ascii?Q?1Q63pk3fkvHCrBTHerb6at9So3MylNu94rul6RfH7N9rywprotiBEDl64h+/?=
 =?us-ascii?Q?o5Gla9CbURuIu9nQ7HVRJbLbSPN2QtRBPUhCzTCqehvcKZgiDbFzr4EXodpi?=
 =?us-ascii?Q?YCVJFXTZnJXm8MDXtA7/ULGh9x9HxQDZgkuF1xSnwqeB8Ahcwwe44WxxMH1V?=
 =?us-ascii?Q?3ywr/8uT9CD1sB3Zv0xx0omN7ISkBGJEJBYDkB+VzaNP9nOV33zk8TWG5qgI?=
 =?us-ascii?Q?/0v9Fj5LF8Ew7WieTtmmObqKi/NJ+hEMFa/C7Ks8ljiQJzTBMLzvm+Hrplr/?=
 =?us-ascii?Q?P6bAMRjaFUc+JlWtKBCyfis7MTOgVwDY2ik6vCCRmooOdn/u2lpI8j0Zz4kf?=
 =?us-ascii?Q?oBaYthPkVr6DY57gOj36NG1iTeIzXrkJuq+niL5DgpHLs5692mupETU98xOD?=
 =?us-ascii?Q?mNQLxywI7E8kqhgJcIWiGW4Iuc1JcwzUyCIqIfKetPIKwTyImw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gN//PLAr4ggYw3GI+i0mqkdoNKX7CiXHfFPkjRGPFR3D8YXZte/ZGznqk0vR?=
 =?us-ascii?Q?7ICLrT7620g/Q9JJT9lWHEYv4NK42ZXlcGut4Urnxl4Bb05xjMnbPq/xz5W4?=
 =?us-ascii?Q?OQMrSqLZ2L688xmtvtysy6q8n1mjq3xraV40/oVYYZRCLPpC8PZHKmVk8kh7?=
 =?us-ascii?Q?Zj90gjtlWxm2dJf/o9IjE0BRUtBX+A6XtnQVJ2GzxxfI/6XMqPl0YeSzE93S?=
 =?us-ascii?Q?A9ldPAI7ik010UZSu7BJ99fY+p2NVyhm96IscPoosDOFv108+xUeOQqhK1wD?=
 =?us-ascii?Q?DaUcRpsmPWIbti3ws7xcGELHIJB1FvsC3w81rmvcOyTVmUnWL1p2aV0gUxCb?=
 =?us-ascii?Q?WWCfP7e5GN2edN7R1soUpHeO6Qod5HnFNII8i2EzdVmi1OPpaPvQ73J9SRfX?=
 =?us-ascii?Q?c6/ud3vOIZKxj+CgiNdk2PG4Y0OYMVKY3DyWAy97f5xvvO7KOjZlyCxPxmKG?=
 =?us-ascii?Q?xEEZ5IHnACUpOqAZkFZJA2iuScj+aRqFSQzER6C32MpAXai3uao3cpTIY1sO?=
 =?us-ascii?Q?N+RC2HkR3Gvf6laYoRfAj9uLdgyqxVXvmJG6j9+uPJTt34otsHbqN25WtT+L?=
 =?us-ascii?Q?tfpOTJnnQrU2u1irwpuuQC0dtj2LDQQyGYq+IMHM8895x6hdGldlOiksQhjW?=
 =?us-ascii?Q?kOl1+XsMel5q3i0PIXzJ4YITYArtpU2cPW25hdBemo60i0aV1otxAkgqW/U0?=
 =?us-ascii?Q?5MNjrzhHsE/rgvAu+duEL3vc/B+1o1UdwfnuroruOSsKAJIsxk/WPF0QUCKT?=
 =?us-ascii?Q?c03ggGvkXk2EznxKE9b9m9Ok5WMLweXkuwCKT/1QaPjEigYdGWflBp2WpdP2?=
 =?us-ascii?Q?DYA1xEAsacMkzANxwbFj9AQ1MY8PWc5PmNJRsf1YdpPSvuDHN+lEUfNS+JKU?=
 =?us-ascii?Q?ovwZm7BtvXVbjo9T2tRBXdM8sHMwEZ0YrQYGjjveVcT5U7Aa2SMKH1lakP4k?=
 =?us-ascii?Q?ySjzRD4aaH/WFVs56p8gQbElSfu0+VfLzDq7QOocYRdOWMSk0w0xaG/99fLo?=
 =?us-ascii?Q?+Wbiv8WqczKp7e8T8d6ZJKW21eXz+AaOyctuIFJwcyoXZbKWxKC6Y1uEpKqU?=
 =?us-ascii?Q?7GJuR8CbY0zknH0SYts9xNWACXGv+pDhm5yhkSXr+jdgsGYt3rp6MLHeXhro?=
 =?us-ascii?Q?ihLJ+OnyiA0E4hAM++kuPcfhXZHxDdKdxcfNx8Fry9Jjg7A52GfFUETt54Mn?=
 =?us-ascii?Q?QZMKHfjJkEm+3itI7ygaJjmjWnTrCBEUvUi8KC7AUqxWrY9Q8GtmpDfHqx4K?=
 =?us-ascii?Q?QIVs/UDea0ahOBDGYCPD2WlLNPV+sgqsq8ViI6O4iF4ERSpjo1cM0sbsvUVe?=
 =?us-ascii?Q?gNRBIhXhifWsD9Kq3Y+k0ww9IOFOkQeygjQIaHK+5UKt4kMnv8EOHRHSuyap?=
 =?us-ascii?Q?CRyQv7rx4T/DuNC4gqttJUABiD2D4X/NY+u5s9nY5FQ0qIRdI4lvlC9GG5jt?=
 =?us-ascii?Q?dI6Io3YjXzGaeEXHKuoxsP0+HPF2Z1a+wMw3DruTFFhPRa3ZRE6ss1P1nIik?=
 =?us-ascii?Q?0Hs7K0P7JDf2diHfQjH/aW0wMvrVdHKViA8V9v/V57rnMj9gWJ/jlL0jbPnN?=
 =?us-ascii?Q?lhmlTMPZV1t1cVJkYe8kc2cQ58xLUdwPZHyiXnR8kgFJ7P6FlxyENmQvMC1W?=
 =?us-ascii?Q?IA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9B9671D5CB6B884DB3954F044BBFEAF8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dngOAUXpHrhxIkddXDEvZPmO3QGyPWOQ2mbLCjK9vW/vWXdmtxIvHaRMvEgY4Y2RCDsQNa2NqytgQnrA6ps9sbrj2sRC0oB7xACHrigKt2CtnuxBQcYPQNV0ra3BSZHPsIa4adwT3BU71dqQ0HW+XPlqSvWZEA1E8FigqdKdhvHvAcs8nQDkIbv3K4N0/7yInx229AjPfnk2WDmRcbknYc2UXBddyAIl3ldbTCEe2lSovo8X4ziGKG44PeWNJtOfksnogRI8cZyB5mgsGIBBZZvXuk1fT/mslUc9437JKyJf7XutdxwTsUQbIfXLnTsyGhWf/E10WsQZBf8ygrDGyVb6FcGc/pgifFwKr3sGy6EhTwG3eUK0Rzjvh9PZzcTKC4o880N/b0zlejpa0KG8gCL+Fh2YvJ0C7xCRVGhGGp0y3cXZs6a/hJ6L9eIDVPcNOe72d+8KxDpvEUOWBo4Se/+MmPM7cT4PINC8oYV89Er7wjfI4XJ8xLqAyKy46dfi5cSJ5sJbS97xJXbl62BixHkfqq+B8kWkreSZQpN39VQ5rH1bbZY92qQXGAOvMUMpVXY7eQvaQCkU9z70EibwBnNUmZiulm/S46vxbga1OQfykG/pC2HAhyTYbKpD/MUv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd6a0cc-116d-4bfa-d471-08dca17e3d1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 07:51:14.2732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o+zRVyB6fa9mBzqNeu9HJeWbAJaPbk+GyMZ4MTkaMWtAAIGKuyvh822A5v10l6kVn2KTaestWqBABwTf01Idfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8090

On Thu, Jul 11, 2024 at 08:21:31AM GMT, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>=20
> Update stripe extents in case a write to an already existing address
> incoming.
>=20
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/raid-stripe-tree.c | 51 +++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 51 insertions(+)
>=20
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index e6f7a234b8f6..fd56535b2289 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -73,6 +73,55 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle=
 *trans, u64 start, u64 le
>  	return ret;
>  }
> =20
> +static int update_raid_extent_item(struct btrfs_trans_handle *trans,
> +				   struct btrfs_key *key,
> +				   struct btrfs_io_context *bioc)
> +{
> +	struct btrfs_path *path;
> +	struct extent_buffer *leaf;
> +	struct btrfs_stripe_extent *stripe_extent;
> +	int num_stripes;
> +	int ret;
> +	int slot;
> +
> +	path =3D btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	ret =3D btrfs_search_slot(trans, trans->fs_info->stripe_root, key, path=
,
> +				0, 1);
> +	if (ret)
> +		return ret =3D=3D 1 ? ret : -EINVAL;
> +
> +	leaf =3D path->nodes[0];
> +	slot =3D path->slots[0];
> +
> +	btrfs_item_key_to_cpu(leaf, key, slot);
> +	num_stripes =3D btrfs_num_raid_stripes(btrfs_item_size(leaf, slot));
> +	stripe_extent =3D btrfs_item_ptr(leaf, slot, struct btrfs_stripe_extent=
);
> +
> +	ASSERT(key->offset =3D=3D bioc->size);
> +
> +	for (int i =3D 0; i < num_stripes; i++) {
> +		u64 devid =3D bioc->stripes[i].dev->devid;
> +		u64 physical =3D bioc->stripes[i].physical;
> +		u64 length =3D bioc->stripes[i].length;
> +		struct btrfs_raid_stride *raid_stride =3D
> +			&stripe_extent->strides[i];
> +
> +		if (length =3D=3D 0)
> +			length =3D bioc->size;
> +
> +		btrfs_set_raid_stride_devid(leaf, raid_stride, devid);
> +		btrfs_set_raid_stride_physical(leaf, raid_stride, physical);
> +	}

Can we take the "stripe_extent" and item_size and use write_extent_buffer()
to overwrite the item here? Then, we don't need duplicated code.

> +
> +	btrfs_mark_buffer_dirty(trans, leaf);
> +	btrfs_free_path(path);
> +
> +	return ret;
> +}
> +
>  static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans=
,
>  					struct btrfs_io_context *bioc)
>  {
> @@ -112,6 +161,8 @@ static int btrfs_insert_one_raid_extent(struct btrfs_=
trans_handle *trans,
> =20
>  	ret =3D btrfs_insert_item(trans, stripe_root, &stripe_key, stripe_exten=
t,
>  				item_size);
> +	if (ret =3D=3D -EEXIST)
> +		ret =3D update_raid_extent_item(trans, &stripe_key, bioc);
>  	if (ret)
>  		btrfs_abort_transaction(trans, ret);
> =20
>=20
> --=20
> 2.43.0
> =

