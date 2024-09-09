Return-Path: <linux-btrfs+bounces-7892-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CCC97195A
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2024 14:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449FE1F23538
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2024 12:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4611B78E8;
	Mon,  9 Sep 2024 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mKSCUUll";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oGQ3a3dH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBCC1DFF0;
	Mon,  9 Sep 2024 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725885095; cv=fail; b=IzRT5HboiRNdrMtpeBuj2mWFu0+IkbY8QFHNG4Rwykesq5l4zfkOo+3Gc6/OY9q1grfZxsOpzf78nZQTx9TBctc+9J7EMiLAD/eWVydvakhe+4WK6fCdsmR2NvjPnW+swjTontYz63Zl3BbkxXEfr3bbPjWv1Xdrm5S715RCdRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725885095; c=relaxed/simple;
	bh=MdEiHnQZGaOtsM6+Q72/7IQroXC46T2eCEJVDHyWRqo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sSABbFaVceMKkEVtvTcawaij4/Q9FtG0K8BvLBr/8lP2tMQcpkWpzBxlNksWdJu0z8gJDBEg2lQxfSFUDYWcGsr45FNq5tDWDw5B3dFc9pGX0wt5n/1/Q2R4B0EZHIMnTzXH52Pl9pOKW1q7/Y2QyJPUTqZKQVuJ0VPKDp5QQEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mKSCUUll; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=oGQ3a3dH; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725885094; x=1757421094;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MdEiHnQZGaOtsM6+Q72/7IQroXC46T2eCEJVDHyWRqo=;
  b=mKSCUUlluOTHHLmbnMa4yebqH6kfj3gpV7R0PlWPH61oheP2Bpw4DQs7
   cJ4CkzMHSf5mnB3HIhZIVYqMa2jKbBigBGboPTLiRNrlIunLjVDG0aTNr
   qe2/sjiJxien6pZpZP0K0AgUfvvH9p0dbzLjBMM/O6mSTOZTVaEd+0pru
   vyuw5DXeHDmwHFutIvPn1+CGQH+hcGqC+6hBm2BgQk66ykNQlt0Yv+XtO
   ZJ8aT8S7tpZ5lua8anLke0Az6F8XklOsgGw5Wi/jako7bqMSCf3vQz7pZ
   SdYWqWrhrB8219pzujFXLcJhNCOJMtszc2I+oRYKyy3AVHCc5Ane0cPQb
   A==;
X-CSE-ConnectionGUID: hY6mXT6TQ5CE6Z6aMPAebQ==
X-CSE-MsgGUID: Z5Sp+UQfT5SkNULKTn2WAg==
X-IronPort-AV: E=Sophos;i="6.10,214,1719849600"; 
   d="scan'208";a="26234019"
Received: from mail-centralusazlp17010000.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.0])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2024 20:31:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVHLpvBLojDaIIbm1DZSyolqLqtAx0uoKGfnQFUdDYFANpFgV03RHcI0j38Z7UQBJE38VT2j8QVm/xgFcfI1YMWBm4tkddug2ML9XcY2SrB/y/Rfl+ueExPbFQdA6rFB1f72T9TA4WX2SmWKl+a14PSB6slHAWNiySRcD+SUhzFsdhNkoULVjyKCICpl6+3BxUb2ELq53+pSPu0LbVF8xdJfFkUiouxwY5n/ZuYUdJbpqnB0g/vF++Mk848ejpFyJVFE/B75pFt2D4BV+RsiTSnjti6mS7QOs6C65CWdvNV9wmLejg21EFt5wg5EPX8j8xhdJ4pocFR6B9+qmA9W/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdEiHnQZGaOtsM6+Q72/7IQroXC46T2eCEJVDHyWRqo=;
 b=J5iHp6nCQ1xuap2JpasGUBL/CcpwyATFiPG+kJtZupWBqWtRDnNfICHqTZT5vHzO7XgH+5/oG7dKaA3y+QnHYZ8m87dOebZpRTrJKDiMQvFm83r2ftCmsffy53fuZx4eo5CO8PUDSZgO20nbsSpNVd6RdGn72EdhoigpAvOHJUK9wQdZdAZ9nYKzcxxyhWdh8jxvlbMR/g+sdV/jzkOAeqY9QpXg4iqV88ovxn9TxypUbtCn+99zE+2OT2XysJ3yi4CxFBeqXYQxkatQwFS5gPAlh4w01YZCQX0BQnUDZQHUdZ7TPL4NjVxCfp1bs2IJugl2aHI29VnrrZzZbc5lHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdEiHnQZGaOtsM6+Q72/7IQroXC46T2eCEJVDHyWRqo=;
 b=oGQ3a3dHnAbxqvVILisBpMbS1vK/6U5E7hPQhTxUz0leQiqkwdmuCajBjwU9YdfsL4YVizMvDHCtuP4/nICLzmPm29zG6P/LqyYmkCemc5u1dLcKHsHDZrEhoKZatHccJsSqvBDQ2V0YX1s0FwPSOdRLNQ6itEbG6LzfRBpcP+g=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB8428.namprd04.prod.outlook.com (2603:10b6:303:147::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Mon, 9 Sep
 2024 12:31:24 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.7939.017; Mon, 9 Sep 2024
 12:31:23 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, "open list:BTRFS
 FILE SYSTEM" <linux-btrfs@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: don't take dev_replace rwsem on task already
 holding it
Thread-Topic: [PATCH] btrfs: don't take dev_replace rwsem on task already
 holding it
Thread-Index: AQHa7xK0aGvyiSoY206iqCX1Gh7qQrI5cyIAgBX2sQCAAB+tAIAAALaA
Date: Mon, 9 Sep 2024 12:31:23 +0000
Message-ID: <2a190823-3089-46a7-9e0f-14d77ae15692@wdc.com>
References:
 <9e26957661751f7697220d978a9a7f927d0ec378.1723726582.git.jth@kernel.org>
 <CAL3q7H6NP_Rr33cdeV3+=GvseOafowaED-maWhtUw65P4Bti+w@mail.gmail.com>
 <617cf535-4534-42da-9bee-2ef6c2806efb@wdc.com>
 <CAL3q7H4nvqLwk7g=rZ3NVp+W2ttAHN7mi8QO-qy7hqhe0AzoJA@mail.gmail.com>
In-Reply-To:
 <CAL3q7H4nvqLwk7g=rZ3NVp+W2ttAHN7mi8QO-qy7hqhe0AzoJA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB8428:EE_
x-ms-office365-filtering-correlation-id: d1699bb1-be28-4d6e-31f9-08dcd0cb511f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cnMvT3lVSkY3Tzg3VkZ0emhxeGpnV0IzUE5FU05nbFpsTUVwWWs1WEVVUm5C?=
 =?utf-8?B?TXBsSVp1YlN6bFpmdUhiQ0QvdHM5T3AxNSs1YnYwM0YvOFJZbnM1MVF6VG1r?=
 =?utf-8?B?Unl2U3FRSmppZEg2OWpYY0xScFFpd01ISHB1OGx4R0ozOHlLQy9BVWNjaVBL?=
 =?utf-8?B?L2dQb3ZISDloMmpZQm9CVEFpbnRSeENoc1kzc3hGUVBobEIzNG1aMmlteEo0?=
 =?utf-8?B?bm8vcGJCdkp5ZVl0RlJSZDJyWTNjdWRjZWpmZnhCUFdIVUhxQUxNdTA1aWkr?=
 =?utf-8?B?MDE3dks1V2VYN3Y2VDJIRUNndGRvYThEVTc5SXQvY0MwRVEwVzZob1VNSGxo?=
 =?utf-8?B?N1lGQkwvV3c3Mks3OVN0S0pxNnVYTFVmZFV0bklaaHBJbnBZVElOeE5YbVZ2?=
 =?utf-8?B?NmE4VEdWYnQwZzFKL05iUTFOZVowRnFXUXhnQi94SE1pdXh0RStRWmFNWGFu?=
 =?utf-8?B?K1kzK2YxWUF4MHgzeTZWMlBCVEVHeTZ3N1ZiaUNpOHJ1aTZSOWtMK1I5RGxR?=
 =?utf-8?B?bWlsTzhia01HL243RGFHY1poOXo0TlB6azlwbGdGTDFwM0hkenZZK0VsT2x1?=
 =?utf-8?B?YjJ4TmVDSVcraU1rQXRraGxLaUZJRmhPVXV0SFZQSnZSSkhUK25kNkZvQ3Rw?=
 =?utf-8?B?N2RFWk9kWEVNOWlkd0E4TXE4RmUrRTZXMGM0RHEwajZoSHpYU1dBSVhybzNG?=
 =?utf-8?B?eXI0RkpaczNEVGhIMXcvMSswNVFmM3RoZ3BlelArSGVNVWN4Y3F5TEZWandU?=
 =?utf-8?B?U3JocFBTVXA0TTFyYWs1dzlHV2ZjWW5BekJPVHhka1J4Sm9OU3hEeXNVTTE4?=
 =?utf-8?B?Y1lPUndvUHVWYkdBdUUvVEE0Mm9DV21SUnhDVzJ0WGZZZUNYUU0vMkxmR2Jn?=
 =?utf-8?B?UzRKVktuQWFMaGd5eCtKSG5rMng2Z1ZWUEtZU0xFbzBDSEZpOHRoNS9YZkNY?=
 =?utf-8?B?Tm5VZ0hvenFlU09DN0RKOVpKa0lJOXVKMnVERUNDcmRCTjcrdGJObG9vN0dV?=
 =?utf-8?B?dlhQdFQvYThrMUVjOUc4enNEZllDanBVdFovaTVZc0hkdFYwODBsVXpTdU1I?=
 =?utf-8?B?NkhHbzRkTkJqYmh2SS80MXp4eXlxNHZLVzg5bDd1bEt1M2l5MFB5L1M4UjNw?=
 =?utf-8?B?TjRvbzYxSTk1NWU4OTREc2lGRUdtZXRZTHQyTm9PUFdrTTVtbjVGOTlvclZm?=
 =?utf-8?B?QzJEYUxya1RCVHZyOWkvejUvR1JHejJBcmpkSXRwb3RKTkI5VVVPSFZGc3lR?=
 =?utf-8?B?cHhlUEhiYnlISjJDdThiWS96cVpSbnpiWFljNkkxa2FkemFlc1BLWjgwMHdk?=
 =?utf-8?B?QUVoazBETDIyQVFORkhPWVo1Q004b0d3U1dQcmtFOXZIOXJHZlV6dkl5VHR6?=
 =?utf-8?B?MldFc2FJb2xXYmR4Zm5zazIyT1ZDbXRTZS9SK2g3V3dWOVl4SHhEUGwyTTJT?=
 =?utf-8?B?UWJXM05FelhaRlgweG9BQnlwNC9pVDZQeUNtZFRrbkxJY2dkUWpSRnY2WjdU?=
 =?utf-8?B?OGVaZURLcTJGU0JLeUJwdEhBMmpnYUtaS0dBczlYSGJkUlZOckkrdlo4VTRS?=
 =?utf-8?B?dmVPZ0NBY0lsTHBtajIxR0lDRnhYT1hIaHhkZkp2QmptVkQ1MmFkcXVyaHFl?=
 =?utf-8?B?bnhhUmFNUlU5YUR2bWRmaTdxcUpiYVM3WlhvRS9wSlRzR1d5bWlwNzc4dVhu?=
 =?utf-8?B?MjhGNzBidldsSlJBRW0rQmZ0ZG5xKzNhY0crcEJhLzlhNGJXeVlDNDZTQTdn?=
 =?utf-8?B?RFNXU1EzMVI1NVZIdFRodEpkSWhCcHZrc3JNR2ptMm9mMFJuWjZKMVgrMlVw?=
 =?utf-8?B?SHAraVlOOXNjOHphSEdEOW1ZQWxCRm16alZsSkJqRVh3NlcxTjA2MUMwa2FU?=
 =?utf-8?B?NGl4WFFsTDNsNTVzc3RydVdHQ1hoWHZmQXdCZFl0YXBpclE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c2xGaGhrbXdTUDJRd1NDY1krcm5aSzV1WXliTkNQVStnS1B0UzVsZVg1Vms5?=
 =?utf-8?B?NUNIY3lKblFhMExGd1VDbkE0cWJ4ZlZiNkxQclVCdDJaT3l6NTFqRGRGajJZ?=
 =?utf-8?B?a1E2Q29Ua1U0YXZJaXA4cU9mdThxdU9LUUY2Y0Fna2xTWVRmSE93ci9JM205?=
 =?utf-8?B?QzJnV0RUWFI1SFhHRVRYNkpBaXpiai82Q1VNL1p0cnYwUjV0Y245UnliaEkz?=
 =?utf-8?B?QjMxaTRiSUY5d1c2akhjbUI3VFlCUFNrbVpGbTF4eDFudjA2OHRLNFk3NlVY?=
 =?utf-8?B?VTQyUmNhWFI3Q253NmpYUUpVNHhUdWxqOFJzcTdBR0dKYVQzajBVZDNQZFJI?=
 =?utf-8?B?VzRWd09jbEZmci81bENzVlhObXBxZmk3ZUxDMkVNOHFPRm5abWplcnA0OVdS?=
 =?utf-8?B?N3BKOE4vVy9uTUMrR29wTUpHMG1jS3ZKekp4MjRlL0VocXIwYUFNd1djV0J2?=
 =?utf-8?B?Lzl4LzJvQTdUMWZqQ1o3NDk0eWYxeWxQYTRPQzJIb0pRVHJFM2ViUm42TFdR?=
 =?utf-8?B?SjdaTzlpbHB5ZkJuRW96QjRCdEZSRnRTb2xlUGkwWGJabDd5WTA0SFdMT1VQ?=
 =?utf-8?B?ZEhJUXl0Ulh2aFVTdkR2V2ZoNDNBR0xRdENJRC9vOTBwa3dnakU4U292ZFZJ?=
 =?utf-8?B?Q05HdUUxb0QvNVBXOWkycldWc0NwYjhOdHc2amU3M05pMkh4UEhXY0xaNHlS?=
 =?utf-8?B?QU53dklCSDhGTEdnYjVaVlZrTnllYU1tWXdOZ0JDOU1Ib1hoODhLT1c5QVVN?=
 =?utf-8?B?WlZFU0xEUFNHQytPZzU0aXVjWnpIWVgvRWFKRXVBWmp3OVdaMzVBTHN0SW9X?=
 =?utf-8?B?R05mSDVleFpyT2VRTkcxMlFpa1NaZzNMVG1KUm1HU2ZzS2xSVTlvdFBBdFZW?=
 =?utf-8?B?dXY5NlhkTlR1OERFWThoMjNhSXdKbDVCdDBLdWloOEpYVGtTMGY4bnpaMFhZ?=
 =?utf-8?B?RVU3dmZvR0dCV3ZyMWI3SE14YWF5bHNFYWNzMVd0STAvWlRjN0pnSjdmdVlx?=
 =?utf-8?B?NWFoZXo2c0N1YVdRSVcvYStMaFRmZUxtc2hsNUFzdnp1Z2NsWjFpeHlvYkhK?=
 =?utf-8?B?WUluMFVjOWZLeXhTc2lua0YxWE4ydzNJcWVMVlQxM0IxRkpwSkhXeDE0V1ZJ?=
 =?utf-8?B?Znl4aTVoMWpEYTBHei9FS1IxT0VFRStndzRQWW5qL0dPdEVObzlaMTMyU0pT?=
 =?utf-8?B?NmQzaUpqdTZES3R6TVdQVldPZDZRTU5WT2drSnd2b1NSMmsyZDluTFVQU0cy?=
 =?utf-8?B?QUt0aVdPdGF5emF0VDA2bVFLa0E5R3h1TkxaUzdxYklIclN3WC92U0d1UG40?=
 =?utf-8?B?QjBkVW5OVjdpQnMzbXBrTHJOdmQySnhNc3QvZTF0N0c4Y0J2UjAvZE56WDVz?=
 =?utf-8?B?dWZiK01iT2M3ZVRGUXlvdlhxQ29ZZ25Va0J4OVN2Mlc4aUU3T1IzZkxrSU53?=
 =?utf-8?B?cWMwdHZJWWRMU25VTDN4LzZqeGVlSklqTEVzYnNzTktISFhGU3A5ZE9wZUg1?=
 =?utf-8?B?UHgyUXVPMEtiVUJzWlk2Z2FhVjU4UWJwRU5LK0Y1UksveUROejR3SVZYV0pG?=
 =?utf-8?B?MTEzY1BEZUJkZUZwMWZoWUhrV0ZXNGwwYlVaUEh4eEU4TUpsQjBkeG83RGMy?=
 =?utf-8?B?SWNRNHZPYWxsYzhkMDVLanRTMmVvbDhXM0NybHpqdGhuZ0oxQ2JPbFZZc0dl?=
 =?utf-8?B?K2RESmIvU2x3YVBYdmhLWXdmUXJ5RlZDdTFrQnZOeTRTRFdKdE5oVVJCMS90?=
 =?utf-8?B?VEdIU1V4S3habDJES2dLZmxjSTk0TW9uemZOZWRJTEZva25pK3dWeEZyR050?=
 =?utf-8?B?ZzVndlIxZW00c3RHbmQ0OXgwSzF4aXpIOE1pU3N5SllPdzE1VWdDMWRTalhm?=
 =?utf-8?B?VjUwdGs4RVZpT0lQeVFnU3pDT1k5OU1meXRLUlJ1bFdEbEtmeS9HWFRRb1FS?=
 =?utf-8?B?U1NhTTdxNFRVTGxOOVRoWGZsSHV5SWk1eFN0Yi9HZWwvdFNzNDBOb2lnR3Zs?=
 =?utf-8?B?UllSS2RyUXpUR010ZlMwZ0VkOVF1bS9UOTVHa21CWi9WdmxwUjZEaTg1SVoz?=
 =?utf-8?B?YVJJZUlyR09DazNaNjJ2UENISFZCQThiNGd0OXBXVWhpOTFuTnE4OXVicXBs?=
 =?utf-8?B?ckpvMjJ4cEJ6aGdtME5laDVPSU9SNlAxUitZRFplaXY2aW5QVFlaT0JYZjJQ?=
 =?utf-8?B?RHAzZmVUS0tWL0FVS3FEVXIvbGhnOVFTMHY4WWgxUzB5TTA1YUNMWWdvZ2J5?=
 =?utf-8?B?QnUwdkRzRVRyOC9SOHZCVlpNOUZBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC3BB7CD65FB4747B700AA0899C4D3AA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o9xgA4P8R458j/WMGFX91zE9ETLBmfb1Qt+DHLthfbzDuwhVjCl6cG8vIfr6fDQhWc7Xo3jD6jP2yzkZlb4vP6ZcRv6jTLBN3hscXP1cjPFlFYHe3U0zcDcbKqcK4Du+sZ9xq3QJr/lDcOJh/iC9pmDrn2ohQ5ApeOsn1hM8rqKB4PeLaG5fT/fs0gZ3YTzWr0wtaW8EijprVtresXf+MUUDfnKFIW2lla6pQ6azKV31G5W/EkfQAvdKnnxsEdjgpT0u+H4xr3ovQUOxT6c6ih6oov1a2kJ6GJ0hEolqYo4JUZr4wH5yhhsar/cm/EJcyLoWDHsLJHiIRTor9AmTM1PMNNx+CrPO/13kWruQjCOel77Sw5Lt1EM0TVUz0UNnNDcUqGqqgnVfBlwBEcPxqMiN/JZlOl7EcHMoPrYdW4kSXqyBCPF+myx6XJ7yGZB37K6RrkFR2Q8XzOvIVSlRvFT1UfxBCEIVE8EoozO6Mutvd6ucQAjp+CG1Hvf8DAzZxJ7SqLObZRxE72199e9QzIp2MUmDE+B1SzojcvoWiduyfC6A7t8BWJ7e8IZRJh/7d+jARH1E8FhaeSrnoqd32jBkPgrAMnmQShbffzOXU9hhLx0rTT/nS+ayirp1xy1Z
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1699bb1-be28-4d6e-31f9-08dcd0cb511f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 12:31:23.7310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5WTauI0A/15oqdXCDglTbYKbA0UsQY+rLHyf/U15jEJ5UBaHU/g/L6Rg1cv986ZPviv26GKNqackFy9HZFKDQ2R2xfiDAE0vG3DEIgBUIOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8428

T24gMDkuMDkuMjQgMTQ6MjksIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+Pj4NCj4+PiBTbyB0aGUg
aWRlYSBJIHN1Z2dlc3RlZCB3YXMgbm90IGxpa2UgdGhpcy4NCj4+PiBUaGUgaWRlYSB3YXMganVz
dCB0byBub3QgZXZlciBkb3duX3JlYWQoKSB0aGUgc2VtYXBob3JlIGlmIHRoZSBjdXJyZW50DQo+
Pj4gdGFzayBpcyB0aGUgcmVwbGFjZSB0YXNrLg0KPj4NCj4+IFNvIHlvdXIgaWRlYSBpcyBzdGgg
bGlrZSB0aGUgZm9sbG93aW5nIChub3QgeWV0IHRlc3RlZCk6DQo+IA0KPiBZZXMsIGV4YWN0bHku
DQoNClRoYW5rcy4NCg0KPj4+IEZvciBteSBzdWdnZXN0aW9uLCBzaW5jZSB3ZSB3aWxsIHNraXAg
dGhlIGxvY2tpbmcgb2YgdGhlIHNlbWFwaG9yZSwNCj4+PiB3ZSdsbCBoYXZlIHRvIGNvbXBhcmUg
ImN1cnJlbnQiIHdpdGggImRldl9yZXBsYWNlLT5yZXBsYWNlX3Rhc2siDQo+Pj4gd2l0aG91dCBh
bnkgbG9ja2luZywNCj4+PiBidXQgdGhhdCdzIG9rIGFuZCB3ZSBjYW4gdXNlIGRhdGFfcmFjZSgp
IHRvIHNpbGVuY2UgS0NTQU4uDQo+Pg0KPj4gSSdsbCBjaGVjayBpZiBLQ1NBTiBhY3R1YWxseSBj
b21wbGFpbnMgYWJvdXQgdGhpcy4NCj4+DQo+PiBBcyBmb3IgRGF2aWQncyByZW1hcmssIGRvIHlv
dSBwcmVmZXJlIGEgcGlkIG9yIGEgdGFza19zdHJ1Y3QgdG8gYmUNCj4+IHN0b3JlZCBpbiBzdHJ1
Y3QgZGV2X3JlcGxhY2U/DQo+IA0KPiBJJ20gZmluZSB3aXRoIGVpdGhlciBvbmUuDQoNCk9rIERh
dmlkLCB5b3VyIGNhbGwgdGhlbi4gSSdtIGZpbmUgd2l0aCBlaXRoZXIgb25lIGFzIHdlbGwuDQo=

