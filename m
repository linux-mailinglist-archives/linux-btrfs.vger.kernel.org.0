Return-Path: <linux-btrfs+bounces-9956-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC509DBAC4
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 16:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0462824A7
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 15:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E691BD9D3;
	Thu, 28 Nov 2024 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UT0krj1G";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NZAXNFVM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A747A1B6CF3
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Nov 2024 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732808469; cv=fail; b=FGrfw+cRYSifZhsHi+caVkAnpmTvweILqOMtBu9AGyHbqtbVlwMD6t8gpXnPTFsKBOCaBO7Ipv22vzjjDCd0m1JFEQm5KPWxF0c1eOMqkf2+33kuXKFRb4YdtY3eyvEMWbVk5Ati1vNSk/hIks6O4DHT3wf73B0d59259hjstM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732808469; c=relaxed/simple;
	bh=OriGKp6jTWW9ejypxW4aT6kK5ln40Nl84YVOhz9MoK0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eFfOMYz6c7bQRMba8geIC3nX4dYDkd599cU3/htJzqH3sNOLwerNRygJ66ni5qaoaCQih0U4dksXemX9aOs3CQ+SQJm3QagmgHAnd0ua4glc71KwNNxiZjS1udURNTKqpvqqCQTvzRLIrUofLbk8HJGTEXBFAmdqpLtPP6lCQrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UT0krj1G; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=NZAXNFVM; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732808467; x=1764344467;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OriGKp6jTWW9ejypxW4aT6kK5ln40Nl84YVOhz9MoK0=;
  b=UT0krj1GPCHyhQrYph2wiyMDv5gIB2jvZuJF/W/wFhO9xiUrlcJBzsFg
   O6fwvqiDoEiCZCBe1OBX13Te9etv/ZSTaNZaCLkyDJOKii0taQAz6nJfL
   7xfrKTXCffcOTaRmRPUxMWX0tX/N416wxhCCvPfvMOGA6rx0QGR/SkeV1
   c8TVy2/qYbkbX/ORWp2LIbVqn9xkO0YOJviIT7vGUK9/LkJhhmhwxBxwP
   vjSh5kh/btEkQj4biJQgFR+F9nMTP2rBRfevT/HT6f4MMbF7KhGqzQ2ca
   M6qHFAx2QHibT0nBmFmgEjyHF65uA9suSYUe/VoWRlwPQEeKesZXzeWjX
   A==;
X-CSE-ConnectionGUID: NjzLQsdHRm+aIqMHSX26VQ==
X-CSE-MsgGUID: b1ZxeToKSh2d04O3AXF4Nw==
X-IronPort-AV: E=Sophos;i="6.12,192,1728921600"; 
   d="scan'208";a="31950051"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 28 Nov 2024 23:41:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFc0B+FbdKCJVA3lIo9B64qarAaJiWmsr/pceJfk0cQU3BKC0NuNr8IxcQTY53DIdDC8Aiyl8ewn+RwBDKurjqpnpJJA0UkZuHq1RS9firGfZAcNn17OmMwINgA5qgklScdChbod8/sZEXPl2vBf3Tpxe/rhOyWcm4E25undxpbhNiLLvkaYJ90GPuxLJD25Jfx631YYxfSuYU2jMO0PpYfba0R1FgfmrYagK54PR0MRE1sCviANd9tbT0XDaFeOPx2lr3h6p0ZDIVvs/+soZaKOKy9B8JkSnnA/zCdHQhQXiNtsVSGbu3sFywpjoQVDq9RMkhD7YsGNUDQM9HoYyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OriGKp6jTWW9ejypxW4aT6kK5ln40Nl84YVOhz9MoK0=;
 b=EGoLMbencwqY/JDc5BKRGSOpnUiveXgv175el3EwnDfz/KeS5BYlcbNagB3lo6kQ/rBVYK8eTfSKQoCHb0WxPDZ/blsj37tx7vHnVEZsW6PRhsSR3upzF+iQUluOzl38ycLPpe+mfJdmF5QVTbwbGeQqm4cO9rXIBcfViiqlSlVP09083NX3kvEUdUJd9TjR9qCvp20sHUV6eQ11wb0bHJ/ZKVJ1llbK5YpNpCzYbNdl078/oyaotEkCvM/aP+Cx6zxdwJFEgq/Gn0UCGn8SUwX0A87CNIKglK5lLs5T9lccyVm57fTamFA1/ehw3zfrjc1CTzxxoXbKYkA+nPhBcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OriGKp6jTWW9ejypxW4aT6kK5ln40Nl84YVOhz9MoK0=;
 b=NZAXNFVMhfSHlLBQCqWgkIs/596Pm2JfwLofTpS2Fcr4wZU7hCDIizeEAGjUlm3ptvpxoOY5eD7FWXyuMBiS0H27D96ZwhF4GuN5eN4IFmbP+PHuMhTfzNpJv+tJZb84U2a+mfnddpBYHvV9JBGMgS4SlB2aO4eKhYAOHFmUgHI=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by PH7PR04MB8636.namprd04.prod.outlook.com (2603:10b6:510:244::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Thu, 28 Nov
 2024 15:40:56 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%5]) with mapi id 15.20.8207.014; Thu, 28 Nov 2024
 15:40:56 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>, Johannes Thumshirn <jth@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4] btrfs: handle bio_split() error
Thread-Topic: [PATCH v4] btrfs: handle bio_split() error
Thread-Index: AQHbQXnW/xX+KvmG9UWKHG45f+9ydbLMxsYAgAAOGgA=
Date: Thu, 28 Nov 2024 15:40:56 +0000
Message-ID: <90533ed1-089b-4232-8450-b209ca0e8d64@wdc.com>
References:
 <3b491cb4fcb7c34bd8cd5265871ff115395fca79.1732786874.git.jth@kernel.org>
 <20241128145028.GV31418@twin.jikos.cz>
In-Reply-To: <20241128145028.GV31418@twin.jikos.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|PH7PR04MB8636:EE_
x-ms-office365-filtering-correlation-id: aedcc149-e90d-4efa-d882-08dd0fc30cd9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y0Y1TWZOWWpWL3gwN3dFaE5IdmdGZjhpSm1iaGh0NjFLOVlxM2NqeHF5Ti9z?=
 =?utf-8?B?dGFvWnNMOFBua012UWpDelIvWVdQTnlVc0NrQ1Q1NE16VUMyL0paajQ0dnZN?=
 =?utf-8?B?V3g1R0wveTA1NUpYNUlpNy9BTXp4QitYcU5odFdhS0ZoSGI0cE1oOGFkTnhW?=
 =?utf-8?B?SHZobi8vTi9pRjBhR1RYb0ZHcnZJZ1d4N0JwWUdsTllvTzVvT3ZNbjFxQTE2?=
 =?utf-8?B?NzhwbFZ3T3JTTXhxZUpaMXZUOHVNalpiVndaUks4bk5uZWFJTXFxV01lYzhI?=
 =?utf-8?B?eEg5RkhnNGhSeEpmMHR4ck1QcHM1bU9NMmNlVGNLc3BPZEZ0UERzYzJHcEM4?=
 =?utf-8?B?cEtsWjA3aDlTSEFwNmdOOW9EWGZ3N2Z3b042SXducmpJQ2hHeG0zR0VqQ2dw?=
 =?utf-8?B?aHFoM3JabmRzcmZnOFRVL1Y1a24ycmVXbnRoSER4T1M2S09iL3lnNFhDZHoz?=
 =?utf-8?B?dUhFd3Z3Y1pFVFhaVklpWjhTLzRVWjRDYTVmQUQ5VWN2RCs2TXRkYjRKYWha?=
 =?utf-8?B?SVhEL0xVQWpFcEJ6ZjVGaXB5Mkh5WlQ5L2lRano4SSt4TzEwV2phWWFuaVkr?=
 =?utf-8?B?MFdLL2ZBTzNjckJiM0ZTQ2NvVU5ZN1h1S0ZiRFNORjAvNDRickdtNVJpOU1J?=
 =?utf-8?B?Wlk2Y0IrVDNuUVArNGFVc2N3Q1ZiSUhocmt3MVNjVysvOVBJbExHUGNFOE8x?=
 =?utf-8?B?QU0yRDBRMkpwNWNnUzZlRXJ0eTVwWTFRdXVCZGxOOSs4elVBK1Q1Skl4QTlt?=
 =?utf-8?B?QUpEbEl6RjVGbjJxNkF1UFB6aEg2UFhaQVg3NXdlK0lkWU9qTjVOL3doWm8v?=
 =?utf-8?B?YjN3aUZ6RCtIdWFGU2duS0xhaVlzRHNvOGozTnVLSk4wSURydkNpbXdoS2dj?=
 =?utf-8?B?dHZvYldqRG42N1g4Ym1yWjNEUGdmdVhZNmRDYzArT2oyL1pJZndFTXRGdWVr?=
 =?utf-8?B?UzMyS0ZVd3FiMnJKdktkbXh5SnJPZXdWTWJuN0s5OFVPeUxWNGFXWXJtenpJ?=
 =?utf-8?B?bzhtRFJVRklpc0FNU0lpT3ZOclp1dnk3YnA4UkFSTmowQThvalU0WTBiZlVL?=
 =?utf-8?B?SzViRktzWHcxcmJ3TEhxZm5KS2ZDaG8vL2wzMU5Sc3VOaFFwRHJJb1JmUFNo?=
 =?utf-8?B?NmVnbXZuMW9WQURzSjFGU2IwU3FaOXJRZlV2VVRiOS9HRW5XOXNzTThaNnQ5?=
 =?utf-8?B?TVBRNHYwVERvNjVBRXdjQ3l5Wk5ud0lRUW50ZnJyNDFWbDJZcEZiZURmQXE4?=
 =?utf-8?B?MlFaNjhzME5FdHVIQnlObkNwclVkZkRUdEJrbC9wYlV6TVFELzdveFkyRm0v?=
 =?utf-8?B?cDIrSTM5SFVTalp0ZmJtOUx4N1lzSnpzcHlRUmU0OGZEbHIzdDZYcTVHSzB3?=
 =?utf-8?B?UWlqZ2Z2NDBCSW1WL3E3RXZzMGcvVlR0QlcyN1BXVUt0ditrT3loeDliamhu?=
 =?utf-8?B?eW85V1pTVlhpVmZRSHl1MkNuaUdPRFg1dlVKZHFFc2xSVVc5ZGpHV1MvYmRV?=
 =?utf-8?B?cVdzUFgwUHhYRXBlaEtUdnVsTFRzM0JYaS9tSFMzSGdxNFo1ODdiZkZuenA4?=
 =?utf-8?B?YSttNkF2djdONXJ4Y1dSY2gyeDE1UE9NQjZiWUM2aVNrRHlGdzZtZVVRWHMy?=
 =?utf-8?B?dUFBOVZGMDhmVHZzeXp0dFpEa1F2OUJRNjZWdFBMWkpWWUpUK3RtcEQraUhM?=
 =?utf-8?B?MmQ0NDVlNy9LQnJadFFYOG0xSkVLNlpHTExYTzBsL085RHE3aXdZUHk1UkRz?=
 =?utf-8?B?TW5makJqdXJKbkp1ajI3RXYvNVpPUlYzMSs2WklvTjBEYlpHKzVNcE5iT3l6?=
 =?utf-8?B?NnJaNnVZeDB4dThDZTRIWkdYYVZGSmxBKzh3bjI0dFg3UXZuUVk5R0I5RkN6?=
 =?utf-8?B?R3ZkQlhQMXhwUW84OHVBNEVvaHkydEg0emJ1QkNzWWwzQ3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Tzd1YVV6bnZabGZTeDNvRC96QTJpcjBFaUpwTVprd3dua2VVWE9ySERQV2JG?=
 =?utf-8?B?TkQ5VjBoMWpkOGdLdnFXT09iZCt0a0kxblhjcFB1RkZmWkpwRVljb09BdWJH?=
 =?utf-8?B?Ty9vY1o1MUNDNWJ2U1NUN2R0aXRBV0F2WFgzOXhvbWgzMms5OW82U0FmeFh5?=
 =?utf-8?B?UklzRmFMYnhEcUZ5QTc1RFc2ME5DZVhxTWI1Ym9vQ2ZjZER5c2tWTVlLYWpH?=
 =?utf-8?B?S0FQS2U2SW5YWXZMaUQvNEEvMjlrc1h0ZHZqWGVrcWlqUDJzWWVoWjRyS2Vr?=
 =?utf-8?B?MXBqb3p5Snk5eW1CN1dGU08vNkc1YlFwRjdZa0s2OC92MjNTdXhTUXVlcHRw?=
 =?utf-8?B?NmREZmMvbHNtY0EzcHcrZVhUc3FTRUVEdmpGS0FjSTZwNzJkMlRDUitxVjJH?=
 =?utf-8?B?Mm1Uakg4Zy9LOGJ5bzU0YWh6TXdPZUE1YVRlK1hqaWltdEdWeWJnZ2REa3lY?=
 =?utf-8?B?amc5VmZ2M1BUeEN6T2ExaUdoSzgzZXFoWkdxSXBNU0NkT2grclR6RXNacjNB?=
 =?utf-8?B?d0hiRWZCbXVyMXIzaHVEcGRXRXhtS25QdmlZdVY1bUNwU0M3RW5aQmRlSE04?=
 =?utf-8?B?bmtXVXFuem9XNUFoY0xXU3BrZHN1RWpsSUUvSUxGbWVKaUlXbEVHeXlIR3Fi?=
 =?utf-8?B?RllzTVpramdsRWNMamc3cjJIbFgyNlpQTGdqbWZtaStrckVjemF5dXJWcnBM?=
 =?utf-8?B?VUhqYTU0RkV6WXcrc1ErZUpWUHVoL2RHdXU0TUxiWWp6T1BjeVdmd2ZmUTZw?=
 =?utf-8?B?SXNvd1ZCcXdIWFd2RFYrNFJkdEVTaWZIS2pEclIxV0tORGlGcjJ2c1NVY0lW?=
 =?utf-8?B?aHdHWE9ZcUhkNDhNYURwK2pSa3VmUXUrZlR2b2Vpa0pnT1FtUmVuU1RYYzFI?=
 =?utf-8?B?aWdWTlIvNVR2Z3VROGRSNkpoRjBOWXp4c0xBakFaYTF0a2I1VEM3Y2llNHFD?=
 =?utf-8?B?WVIvSzhGdmR2eGp2byttNVBTajZvUlMvcTUxeVk5cmRPckFVb25SS2RMN0t6?=
 =?utf-8?B?aUgxc0dpOUZSNzlXZCtNdjc0b09lSHhKNXl3RGNYZVR0SUhuTzBkbEhVVi9C?=
 =?utf-8?B?WmVlT0pJZEhjU1JDL1QvYVYxVEJhWEpiUkVQendQNzNzQXJ1NXpNaVRBZm1t?=
 =?utf-8?B?d2RYaHZLR3ZYTlBRNjBiVmJ1VHgyTE5uRzExMHBtZFRrY1hEdDlsM2NPNWJ5?=
 =?utf-8?B?S2NTOThEME5pQTdGZnhPei9jU2dxQk5EZVJjcVk1S1Y2dWhhaDVSRkdlYklS?=
 =?utf-8?B?T3lCY256bmYyZ2ZUcGJKQk5mTWNIaGllZTBVS25mM0ZmMytjb3BKcnZpUklC?=
 =?utf-8?B?dW9udytDem9qYnJrZlQ1VWh4K29WMHM3aU9LUFg0WHBVdGVZanQxcnNHNC94?=
 =?utf-8?B?SUtvS3NnZEhMeFVONTdSaEVSVE1RVGttVjBkcFFPbHdzMjQ5WmpPYTNQMVFu?=
 =?utf-8?B?TWlYNzhZSUZka3E3RllqemNycWpNWjkzQis0cXZ0OUloeXJiK0JuaTJHNTIv?=
 =?utf-8?B?YWJXMG9ZODFaU3dtNTFqcUNsZVA1OExRYm1PV3orRGxKdHp5UjBOaWVFNVJW?=
 =?utf-8?B?eFNKR0x5SGNqSTZ2cVdqK3dtSmR1dmZva2t1YWhmbkVMcFdwMTZQSXlKbWJ5?=
 =?utf-8?B?c09VbHQ5MFFsQmRCWFNJYlMwS3VKMWFYNG5pcnpESzZpZUpaYmNIRnB3TVpl?=
 =?utf-8?B?dENCM0plSjF3NlhvZWVIMVcxMi9pMDI3N3dtc2ZWcldJeVp0NU1XR1Evb0hJ?=
 =?utf-8?B?MnA1dEgyWGI1WWc4UGJiRjdXdXBGRmoybms1d05Qb0d5QUZNVm10T3ZJcWli?=
 =?utf-8?B?ZEs3bVQ3ZUNubUtsa1NWeHQrN3hOL1ljQk8wRE9NdDhHRm1UbElkQUlqY1Nv?=
 =?utf-8?B?VnI4dE9rblovNWo2bWhjUmp0bkYydmhvMURLK1dCc3ZRMHY0azFtVyt6MVll?=
 =?utf-8?B?bGY4dE5peFhOVjJXYnNpZERmNjhVUHZ5RWFRZkNtZmdkUmF0azBCVTdGQ3Zv?=
 =?utf-8?B?dTM1RUFjSWpNWHlkSTFiK0d2NVIyeW9DbmtOTXlVRGpFeVpSZUZUaDhvTGZV?=
 =?utf-8?B?V3hMcVdIMENXbFBrYTloSHQ3S0lTTFRyMkJqOHpYaFZwMVpuVHNLSFVVY1Ey?=
 =?utf-8?B?cExQalZYZHpIWFRtU21pOE14ZUFZeHluR3RiUDNqZEI2T1pjVGV5eGljUnRB?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF311BCCC315E543986D496AAACBEBA6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bu0wWv6j2x/zEhLbAxFh35HGAamvjNDxyG9PiQvyYziElsoLrj1Ig9PmyEoVzX3k0dQ3pT7ICqsl4AplrGt9ebmYgy5ONJMIvVsj/B4dyxFw3flSWYlVbucwlov07LRHyU9NVMNHUuqg9aUhDlI2WN/o4l+F7tFWLyTBjOUj51+SNtxiJp+yBCCnaDr8fHLqeci4KfmREUuP9+sLiMoWoy8+iOPpQZ34C5ZyEWx7r4ULf3EQEMAa+Ri60s6l+pIDTR/D5d9NUb7v+L8S0nJ254ECi8S8PEUlf1hjY2ZuTFKIhoL+EJOCOVRLUQp3615dLpt6GU6ZZRevEb5WWOJan8tqaMHavKgWlRRNmrZ/nPOH8ABp3igQNwkzH9CgLfijNWCbXHS0bLl++6eMbDSWLNdx9WvFZMsDEcgmP7snWUWBXXTywldonkcvGWShAiiEBY1dxQ/PQwou3A88tA+aJFFHVCUIetJtn/kXnzNab34Zn1O7GC7946AFVqrc/M3q9dMhb9N++cCsfE+VvzbXREp6l2y7n1/YSm4iqdAhSFi/tqCH10sqShca7HQBk2ZsbUy+SE/t1nsZVf8APqhdhDZReyJwArjdMlTI4JnmlxCpEblEnpuDleTskvhLDUlF
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aedcc149-e90d-4efa-d882-08dd0fc30cd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2024 15:40:56.4632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i9zNAv6Y8kQw20I1Psl86lAL5DZ6ZSDhwVoQ7n89sG0SU4QJnFjsWyrD0KJ/nsGteOCPqLc03NGhIQBALm5IEkd846GxTpcDeAP/JjV5PU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8636

T24gMjguMTEuMjQgMTU6NTAsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gT24gVGh1LCBOb3YgMjgs
IDIwMjQgYXQgMTA6NDI6MDFBTSArMDEwMCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4g
RnJvbTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4+
DQo+PiBDb21taXQgYmZlYmRlOTJiZDMxICgiYmxvY2s6IFJld29yayBiaW9fc3BsaXQoKSByZXR1
cm4gdmFsdWUiKSBjaGFuZ2VkDQo+PiBiaW9fc3BsaXQoKSBzbyB0aGF0IGl0IGNhbiByZXR1cm4g
ZXJyb3JzLg0KPiANCj4gV2hlcmUgaXMgdGhpcyBjb21taXQgb3Igd2hhdCBhcmUgdGhlIG1lcmdl
IHBsYW5zPw0KPiANCg0KSXQgaXMgJ2U1NDZmZTFkYTliZCAoImJsb2NrOiBSZXdvcmsgYmlvX3Nw
bGl0KCkgcmV0dXJuIHZhbHVlIiknIGluIA0KTGludXMnIHRyZWUsLiBJIG11c3QgaGF2ZSBoYWQg
aXQgYXBwbGllZCBsb2NhbGx5LCAgc29ycnkgZm9yIHRoYXQuDQo=

