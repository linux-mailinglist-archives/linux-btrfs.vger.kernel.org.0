Return-Path: <linux-btrfs+bounces-2345-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9263852A57
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 08:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6474A1F22861
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 07:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AE017985;
	Tue, 13 Feb 2024 07:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oo7Wy7Kk";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hlCG9C2d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7246D8F5F
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Feb 2024 07:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707810958; cv=fail; b=aDyBr/ORelrM+1LfZ0xFNAxQYs7FqxP5KBI7d+uVmkyEqXVc/fI8cr+lnc76Hs0h6c6ZABk/lGGXR+9KKhdUSk9UjDA4YmzI6t3ycHHKsH2y66IlNrlNK6+B3QVj7a02eB4BhZQdCw168LdOS8cVf4NCJ6xqV6rSY8/43Fn26yU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707810958; c=relaxed/simple;
	bh=A7D5vbMy6oLMl1pTpzm8xsyIT2ZcIokDguq4rf93dj8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AWaXJY2Q3OlykkqmqmwrU4P0xOwt+nMCXjzlHPn/A+NkU2JEchRSHcRkpSRxDu31ZLNfMrBWHwXp8ctHEChgRb7HoF2h31ppe32E3E6GhF6P68FHRQwC7wjRV4TMs+L1lJQ9vf929OP3kxRJ35ZZLFwE70TKOddiChC9Dk/H910=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oo7Wy7Kk; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=hlCG9C2d; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707810956; x=1739346956;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=A7D5vbMy6oLMl1pTpzm8xsyIT2ZcIokDguq4rf93dj8=;
  b=oo7Wy7KkTiIifvWPuWhg6lCjPMHa/2OSrekoizsDoDknJffY4YrkQBni
   e0HBovZhaDmwtqIC9KShS0GqLb0kq7VhghErDY8s8+Mrx7j8/0ngYEopE
   C8W2Pj3Y1+0Gwjy7Fjmf7tPCdli06/ih+EiWMhlVfzugfjadpvwQYDn9f
   4CwX7KnN7lWyw4jKMItwE5jroYSNBzVsSpBJ1BtfgTBCyrg8eB9ckV96+
   UrazuE6miXa3SejOfkdo4QRwQVnOJiyYdLN+MimP0Dz1k4KPuC9c9uUvz
   qWP8M7RlaTLEG/29ePihw9XrihqsIA3FOPTZmNt/h7eYVA9rYH7MtrDbh
   w==;
X-CSE-ConnectionGUID: nQCDMMVwRDyL2YdP5BsXWw==
X-CSE-MsgGUID: tjNLnFbUQGCHzfjYBgcAbw==
X-IronPort-AV: E=Sophos;i="6.06,156,1705334400"; 
   d="scan'208";a="9036765"
Received: from mail-bn1nam02lp2040.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.40])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2024 15:55:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cooQc4nYX/IcVn5R9N37yPCzc+kLG2gRwIAVIudv+/8gjL1BvNXOlwFWu8j07A6V8LIiM6pFMg9KY+ZQtfGr4mRmfnfFpOZmkFEZiv340nJa5IDyGdfnO8wdMVOQNb6CfLwdNVOtiTPlrIITMJ9yYFIGjZaJpgXFBCA5Yt2VYsdTDov90ph3cWpmBOo5lISk7O74f3uJNALnV1DNKlWbrlDHDyVyihVNOwwVScKwXBajtiOMHq3igZhOS2RdvQDgT7On0Vm/HffeNDx6bRqziuf89e95TMr0XxgXnk4LBsFUfYXjaZjjO6bB/3uKdosmC7CwB1DW/TbvFqx/CaWAWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7D5vbMy6oLMl1pTpzm8xsyIT2ZcIokDguq4rf93dj8=;
 b=Lu/Tu00L/6Kcl6DVZXOu/PnwStnfef45xTKGuyRduc85qT67Avf1Y7PkvnZmmvdoRX5n5TeR9QE+XGWkZMlTnhY/22NOslBknaYf0YP6H4oFSxR8Rb2f/GdTO23GCAx33oQ7EAucdvnOMxOjXD0bZehjnEbEkOMCxkbf/LwBPZS5U5ycY4azKDcpzIt5nZTTEE4/Zie20d0y6qiuZuXgGpcrBjNipjWIm6FMGCtve6SOdQsmUtoUVRLJqo6427w4jiXa4fiwfJMCQh/zJWscYwoutcsehoxsq5Y1MMP45pcJ7KjVDonLAQToMdUa+lNq7j6NbxXSc1AkdENEGYK9Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7D5vbMy6oLMl1pTpzm8xsyIT2ZcIokDguq4rf93dj8=;
 b=hlCG9C2drShOU1U9LAAuZhE+0iI9zA+xkuhYk7qbkKjjxLg+6gbmtyvbkgVMMINKWaQp9IRN7uwk2cTN8h2ni3uUjpGC7XlyLh5Ktm4Vh5N6ZzULaczajy2Px4Ct9PhZfkMXLrYuKtOm0kxTVBI3mkQXnMWxFGPElQk8R6WY09A=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by BL3PR04MB8106.namprd04.prod.outlook.com (2603:10b6:208:349::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 07:55:52 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::a8a:ec30:a6cf:8e1f]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::a8a:ec30:a6cf:8e1f%5]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 07:55:52 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: zoned: fix chunk map leak when loading block group
 zone info
Thread-Topic: [PATCH] btrfs: zoned: fix chunk map leak when loading block
 group zone info
Thread-Index: AQHaXf7ICY1XFuXLTUa5HJSk0Zyp3LEH6CMA
Date: Tue, 13 Feb 2024 07:55:52 +0000
Message-ID: <56857cc2-c00d-4314-8c80-e674b2f3fd7c@wdc.com>
References:
 <0bdc61c9216d238eaa4abb6edfb1c5d9c8e86c52.1707775003.git.fdmanana@suse.com>
In-Reply-To:
 <0bdc61c9216d238eaa4abb6edfb1c5d9c8e86c52.1707775003.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|BL3PR04MB8106:EE_
x-ms-office365-filtering-correlation-id: 32cb0df6-b854-4c69-db4c-08dc2c69333b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 AMSJKNYcnQx2txTp4VWfzPxAO2ftnXwXK7tqVphXXC6eDi2xzI/tNOl1m7RNBjVWLHupCr3IBm0PUniv3IbcgOfYBnMMNAGijl79rJT9DUYV8bK9NHuxmLGy43k1Rn456nYXTp83cuBYtuYcXxl00wSdCZ2bMZg7VxVJiHC85LZ1/LAKea6TuNakejQPVm5kdSEe+r5/oMo8y9YTm4rHlxXJS4/indcsfQdhlGfQ7K6hbL+4vJWKDW82oO7tFEIkXmfI6CcGW033iNz/hVem9y+RS06DvN//5pYtPWUHkP5WQb/PEMBamC7TIpEopK0RvPg4uqj4wABWLgy4Dn0kVF9xP56dStuNo5+ZieDQ4/8wMKANpsDuSGFxwFfWAe+OUVxzsoLkYZNC/S01zCtuwWovOYZ1tpcPe21a3oITWe+tjQxuO8E1APSXHh96WSB7abFp9T7YMeipVQAcAzfN8m3NqasvCal5e5MCqMU8GfZxa3CbiEa5AzzHik/n4rbLk3VkPju/VC99B25b54BhVuPy7aJZXWtxHUnVoBKEExu8r5zCE4HvC2c94ZxadpMaijpULtTu70EEEKqELnjmwzseoVdp92Ntgxmg8Gj/kPXREHx82cnjFTasdtlJcnuJ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(4744005)(31686004)(2906002)(83380400001)(53546011)(478600001)(38070700009)(71200400001)(64756008)(5660300002)(66476007)(6506007)(6486002)(6512007)(66556008)(8936002)(8676002)(66446008)(4326008)(66946007)(76116006)(26005)(36756003)(122000001)(2616005)(41300700001)(110136005)(316002)(38100700002)(82960400001)(31696002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QVdHL3BjTGJEbVR1SGVxdWZiV211ZXVCY3h0VmwyUHlHME5lZzRYUnZhNnJx?=
 =?utf-8?B?SW5GcWxEejJZTDEzMDdWMVFqeEFBdDJidjlpT3NhSHNpWHNQdVZBNjE4ZjJz?=
 =?utf-8?B?bVRhY212NVVqbCsyRndudFZRMGpEa25QMVFhc3FrYWU1Qm56ZldFZ0FBNXVM?=
 =?utf-8?B?K2VXWXpsU1RkcGtxTVgrVE5DdmZoOTZwTjdtVkpnV0dNaFFIeHh0RUxDRzcz?=
 =?utf-8?B?MDduaFdhSkUrMDFiOHVzT0JjbjNPL0xrb1hhemJ3S29pVTNmM3dQOGREdlcz?=
 =?utf-8?B?cjM0RE85dUx0MWpIeno0a1ZTdTlUSFdlcUFQL0Fmb01GekFTTkZuaGszcHFP?=
 =?utf-8?B?azFwUGYyMm9BcEJDUStnaUJSR2UzMitRQU02UE1TbHp3ajF5YmNidXBZRmdj?=
 =?utf-8?B?WGlWUlNZeVRTVkFPMzdUbUMyemRQZHpoQks0VSthYkROS0tjYVArZmNJOFZ6?=
 =?utf-8?B?anhGRmFiYTIwbm5kbTdxV3IwTHFrZTljK3VzSXE4V1QwNEppcXpIc1g1SFhH?=
 =?utf-8?B?aWxzakhLNXlCS0ZEUHdZTXVyZnUyMkxNdUlwdUozZER2UU9FNHZxYWNzaVdw?=
 =?utf-8?B?bHZ4U3FDSzFhL3NxbnBnNG04djlpWUhoMVF5MEk2bTJkY25zNXlzT3hQbEI2?=
 =?utf-8?B?MHRCRzdHMnpZZFpxYTNBelFHaHRPOE1SNWxtSk1lckg0TTRRMU1zQkg5eGFm?=
 =?utf-8?B?bTYxVFZmYnZSaEp5UXE2ZVcyTytVaGRlVWt5THl1bHlhbzd3ZFFkcUpNbXVw?=
 =?utf-8?B?dkp2dDN3akl0Uy9ReDA4SXNNNEZ3R2RMKzd1TjRZV1VJR2hCSVgvYmd4OW1h?=
 =?utf-8?B?NWc4UkVlQWtCSDVIQWxiWkpySEhxQk5sSVRWb0R2QnNPcUZsZlI1MTNVZDlZ?=
 =?utf-8?B?ZTc0NlZuQnVsc3Q2VFJPMnlONTUvVm5iZklZZmMzbk1vUHA4YmFHRUE3and2?=
 =?utf-8?B?eG0ybkxrL3pJTFZVM3loRytTU003dVRJSDFtZFBYTkVkNUdUdHQydXpxVlVQ?=
 =?utf-8?B?ajBITUt3ODRRbFJXQ1Q5RlVsSmR4UlQwbTZkZEtYMnVjYTZQOGFudHBvSUp4?=
 =?utf-8?B?MzEwcUpmTzZ1dlI0YU1jZmlYSThLempIU3VNYWlyNXUzN0loK0srU0JKUnBS?=
 =?utf-8?B?QXdqSHV5bGxDVTVUcEZVeWs1OGFYTGFHN1gyK1FROEs4bFlZSmVTeUh6ZTRZ?=
 =?utf-8?B?UUxRemRrSG8xc1B1ajRjNnJUQ0EweStrZTZlZUhRZ2QzeXVyR3prWWQrMitx?=
 =?utf-8?B?Q090L3FLVjRrWmtheUV5akhzaHgyVFVnT010Q0V0am9waWlqVHRWUjh6WW5Y?=
 =?utf-8?B?bVZDb1k4L3FYN1FSVHJtS3FBaVlxaU00MHNCM1lXb2d1d3ljOHU2dUE0THJW?=
 =?utf-8?B?dFVKbnFEcHhxcDJXQzRFVUh6QWpyelZsbG9iV0ZnSnFNY1F4dWVEeGpiajhP?=
 =?utf-8?B?dW9ZdEFwWkxsRWJkSllmc1FXSnFTUXBaRUhkU3V5VFlJc2NqL3lCRUtGdzJj?=
 =?utf-8?B?Um1qSmx5c3FidnltSU9MYTkvdU1EQWpjYzZNMFNJamxYYTZQVURON2h2ZkUv?=
 =?utf-8?B?K1Q2S2JaWEV5TGUxc0lIb0VVTnE4OEJldDBqTENxaEdia1hpK3BTMlpCcFUw?=
 =?utf-8?B?N0oyaWFJdVRYVExTazJQMEdGUGQ2M0hKS0loaTRNRkozUmI0dzBiNEZ1ZTg4?=
 =?utf-8?B?OHdRWDY3V0NaVk1vSjVZQk9jclJPWUhMYU1nK0ZmcWF3aEg2UzN1bmV6WkhF?=
 =?utf-8?B?TkI2MUUxVmx1bGNFZGxaeS81NjZ3Q002Nk5hbFpCZkc3SXl2enRUQWlpOWdJ?=
 =?utf-8?B?Z2FKM055Vy85VjhIMTJDYnNNQ1RpZjl6QSs0WWlreVB1RlNsQ3dESlpOU2dC?=
 =?utf-8?B?SUoySGc3ZHNrQjJXV1RYZmsvcnFqcitXcXBnQW9hekdsc2RmOEhzRE9VQWU0?=
 =?utf-8?B?VER4M1lmb0Q1a01NdEJEbEFUTWNFbnpQZFhLT0NFcmxhM2dNbXdSSlppYlI2?=
 =?utf-8?B?bGlYb0Z4a1BWaFZaYU0zMmdrT1R1SzRrVVY4NU1vQkVISjRJeVFFMU5ZL2l5?=
 =?utf-8?B?cUZIS2ZLa01WVkJ1d0Z5T1JwSjEzb1B3TU5ENGRIR0RvSVZKU0h3MU9CY1dQ?=
 =?utf-8?B?L0Zvb3B1RFp6OWpja2pwdFJ4NkhyVFh3KzNDSEszenhMcEs2bHIxTUE0K1lR?=
 =?utf-8?B?OEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36249B19A64F46409F4BF9C7E3DD725E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ip8csQ6a2QFByXfzYTnSJ92rlYCj4apBdMnOrGAWZ2Z78hVQ53IVTN7ROcHpujA1MeTGr8wKuEiKPeJXOOmn6ADZxQWDgCgLOuGG6ytLHwtDLQcSlIGEjVlGlDYsAOXnkgs6Dj00Lw6MQrBCKOkwxbWP0D+YfxIkYyvMthR9QjfDVePxLLHyE2FGlEVY7qoQ3metCcNYaU2iOMiMFd7Wf3PlWrK7REsAqBe4RFgUN6edgSMjbIZySoeBUZ5l0X3x+SIuWVvTpp8R3BBURtDnbZJC9+mhs/YLYex4n6IqtVXbDOUuV4weaXzDgmRGnjvzJ7x0HrP4UBFRs0PN4y5x9WJ7JUkiKpBpByGJBMi95dGTj2dFshOq+C5U8m+rub2+S1dUJLHi0xXOfOycPQJog3TQo6il6/sSXOAtj/t0pH7AkDUVNREc/rw+DKoEpoUG5S7BcHgt3f45Ohh9hmcMWPfGZNgY/iZiYk7O0zTfjcviUq4T6xMXixDfk3PLoCFxK7njoDVoOxET87EhRyzmBPvoLgw3NKf8auNWG1UvlgeY5ZyT+7QajGOvL7urbjPUtWwRXf/CZtI5qgFqr3tuCYHk3jzntaio0GQz2ZZC2pt5kp4hWBnyXYbM2GVZMAow
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cb0df6-b854-4c69-db4c-08dc2c69333b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2024 07:55:52.2385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VOReYJRhrZ8F8tigt8Odt80y4dKvbRoA6JWHvmbSIVmJZeziJsngGDpA7rRbePCntbt6tCJjeUA9xcP5U4uz1S+6p9X1eyHFi2SG09WlrAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8106

T24gMTIuMDIuMjQgMjI6NTksIGZkbWFuYW5hQGtlcm5lbC5vcmcgd3JvdGU6DQo+IEZyb206IEZp
bGlwZSBNYW5hbmEgPGZkbWFuYW5hQHN1c2UuY29tPg0KPiANCj4gQXQgYnRyZnNfbG9hZF9ibG9j
a19ncm91cF96b25lX2luZm8oKSB3ZSBuZXZlciBkcm9wIGEgcmVmZXJlbmNlIG9uIHRoZQ0KPiBj
aHVuayBtYXAgd2UgaGF2ZSBsb29rZWQgdXAsIHRoZXJlZm9yZSBsZWFraW5nIGEgcmVmZXJlbmNl
IG9uIGl0LiBTbw0KPiBhZGQgdGhlIG1pc3NpbmcgYnRyZnNfZnJlZV9jaHVua19tYXAoKSBhdCB0
aGUgZW5kIG9mIHRoZSBmdW5jdGlvbi4NCj4gDQo+IEZpeGVzOiA3ZGM2NmFiYjVhNDcgKCJidHJm
czogdXNlIGEgZGVkaWNhdGVkIGRhdGEgc3RydWN0dXJlIGZvciBjaHVuayBtYXBzIikNCj4gUmVw
b3J0ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IEZpbGlwZSBNYW5hbmEgPGZkbWFuYW5hQHN1c2UuY29tPg0KPiAt
LS0NCj4gICBmcy9idHJmcy96b25lZC5jIHwgMSArDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvem9uZWQuYyBiL2ZzL2J0cmZz
L3pvbmVkLmMNCj4gaW5kZXggZDk3MTY0NTZiY2UwLi40NjUzN2Q2MDZkYzMgMTAwNjQ0DQo+IC0t
LSBhL2ZzL2J0cmZzL3pvbmVkLmMNCj4gKysrIGIvZnMvYnRyZnMvem9uZWQuYw0KPiBAQCAtMTY2
OCw2ICsxNjY4LDcgQEAgaW50IGJ0cmZzX2xvYWRfYmxvY2tfZ3JvdXBfem9uZV9pbmZvKHN0cnVj
dCBidHJmc19ibG9ja19ncm91cCAqY2FjaGUsIGJvb2wgbmV3KQ0KPiAgIAl9DQo+ICAgCWJpdG1h
cF9mcmVlKGFjdGl2ZSk7DQo+ICAgCWtmcmVlKHpvbmVfaW5mbyk7DQo+ICsJYnRyZnNfZnJlZV9j
aHVua19tYXAobWFwKTsNCj4gICANCj4gICAJcmV0dXJuIHJldDsNCj4gICB9DQoNClRoYW5rcyBh
IGxvdA0KDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hp
cm5Ad2RjLmNvbT4NClRlc3RlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVt
c2hpcm5Ad2RjLmNvbT4NCg==

