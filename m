Return-Path: <linux-btrfs+bounces-16819-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692DAB57B51
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 14:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1CCF2043BF
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 12:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CDC30B529;
	Mon, 15 Sep 2025 12:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IpQch9gh";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ymkrR4Xv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2B12D63F6
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 12:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940121; cv=fail; b=tbRQbKprV2KgKkwDaEo9mFuGj3RCcD1DLZvaooapVDULGQK4uaDFFIfhFDLLLOMFWKxSzQTiP/ytMQYFT9lxKFiMm1vns7zkh8al7iP8dO4so69K6N0492wCAbqmTtzubJM0vn7a+zoZIEXo53lF2spoR7O70bCfMavrr9dW5Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940121; c=relaxed/simple;
	bh=4rW/G62Q3IbDVaTBX+MvVK7vHQusNlVV3ziqEJWvOys=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jRG7x7/L43LSiTc9YIU2nJd6UtVSoMo1hXSvL6Mdmj2OMiao1pf4gMownJwQz4DI8NilkcSP0yW3IdxUM7eF30Dkp1Du0Yj8BNvNXibkKW49vm+pGOtW3HrbFl58dgULn4Ww2cPrUPPnr2ijLwI0Ce3AFp/9gI45ZYOLypBk0MU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IpQch9gh; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ymkrR4Xv; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757940119; x=1789476119;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=4rW/G62Q3IbDVaTBX+MvVK7vHQusNlVV3ziqEJWvOys=;
  b=IpQch9gh4bbMNkScWAHmbEq9Pq6c5CPHbevhnVvnRbnFSw0S2N6rT65T
   FMftjyJD9t/PSkFDHc9/MmnoJM54CgW6BcLKMx7c0n2e/JZU9B6/ODTh1
   5IQ6QKX69pTSRHpoifDzAUhX6XpCkFQ4dEPGEUfp/yIEOfLIoy/9NlqE2
   yosRftzF2sWSuKBDOkegsEh9u9u/U8fhs8mJCwpR1Ak6nPvtGUfK7R7Nv
   hl3hYdUm9s+a9oBuyairaAyQs7HACq+S3PBI7tm/PV2cYFqQpTVBFkkql
   rDxUNc8k/9XvsZk1gnlW4CEu977W4tVpo2ykEShalZvZdWb5pr4FBBeE2
   w==;
X-CSE-ConnectionGUID: WQvKflHFSu6ihkZ5f/PJqw==
X-CSE-MsgGUID: KvgrxBW8QhG5d6UVpWLPjA==
X-IronPort-AV: E=Sophos;i="6.18,266,1751212800"; 
   d="scan'208";a="118157481"
Received: from mail-southcentralusazon11012036.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.36])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2025 20:41:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UkDA8U1kDj7HE0TLd6blH1XwL6v0n6QKBto8/g6Jj7CHvdMW9oDg7nTchoYR+7z/i8LwQ084xJabW7IXma07rK980FbdOMi4skE0/65Cg709O/Ejsn26j4KcH4vmUNlR2B2ARUy9laja1Dn3+Z/mCSNzwwAwXQWoZSBPwblBL3pifhG9juD7PvKB6mAOfx6Z65tGHhhM2Vx9U/DmlyZhhQIxso0bM+5xFV/qSVZJg1qzhePFRanqPqYXjBGZTGw2IZH7iEV/W+X3ecJYzjoLRpz55NT9WErm9+kz3kzFXpDaViuT46a7ZWzqa6irmwqVrgVVxew4rH5WX8PR61ax7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rW/G62Q3IbDVaTBX+MvVK7vHQusNlVV3ziqEJWvOys=;
 b=W1IsLMBYsBiYj79qT+QinrPMUwX3tmfdaQk8oubptyCdSVuQYl/VW7Pty8j3L3I++YiNNOGbHkx/teVSBj/fNp8pGV96/7JfGHCVaBGXDxLx/OYzO4pqemmV1ghll85L7u3oe0ksDHr90GYlK2m3/4FmxQtP2RMIQxBmMvtUmwIjz/yR9SgCeSAcQr4PRhHDHxzk9exmhA5hBi2rtl8QG4iidJ2WWsW2S5HVVjkKBn5UfzOoDP2wcYmSSldT/mpyfopaOFU0bC9WTnrkxzn1AN69eLON0g4hWGkrVqbVvt2YgN9abVMd+yJdT61OeFB0PfCilXw/if51sR+WaQmbtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rW/G62Q3IbDVaTBX+MvVK7vHQusNlVV3ziqEJWvOys=;
 b=ymkrR4XvTBs+O5DbF1Nb3/sVey/HjUC+3ml0T7P6Wwu2lZMl4O3YxmdL6owYnPG9dhaPk+ahO9iVnkrjMF8sUS30/LHRvzCex0qDbsQYjL2Fx/Iy1s7dJZGggyFBpIpwYe+I7TNoXCOMKOrCQj8+cWf1BY/YLb3QYM2Yof2VPV8=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by PH0PR04MB7382.namprd04.prod.outlook.com (2603:10b6:510:1e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 12:41:51 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 12:41:51 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Yuwei Han <hrx@bupt.moe>, Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs
	<linux-btrfs@vger.kernel.org>
Subject: Re: performance issue when using zoned.
Thread-Topic: performance issue when using zoned.
Thread-Index: AQHcJWG554cLgRNI6kq+V/MRpm0fY7SSfW+AgAGm74CAAA0WgA==
Date: Mon, 15 Sep 2025 12:41:51 +0000
Message-ID: <c2d204fb-efa3-420e-b9d3-2ae45b17299c@wdc.com>
References: <tencent_694B88D85481319043E0CE14@qq.com>
 <873c88ef-ee65-4e27-bc5e-156cf9e79aa9@gmx.com>
 <BD8FA84236613557+a3110e3e-3931-4ff7-a7ac-7347b9808642@bupt.moe>
In-Reply-To: <BD8FA84236613557+a3110e3e-3931-4ff7-a7ac-7347b9808642@bupt.moe>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|PH0PR04MB7382:EE_
x-ms-office365-filtering-correlation-id: 6a1ea3c9-bb1c-4778-50d1-08ddf4553ea0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?b2R4czBYNC9pRDluUm13QTBaeDcyOHBpUDVQKzA4ZThKTU1QYnUxRWFjUG92?=
 =?utf-8?B?dms0MDNaMVdreWNxNE9PbVFhR1BLOHFhTDJqM0NQZDFuNzY2SHFrajk0ZkVu?=
 =?utf-8?B?WWZIVmN5Smg1Ym9jaWVncmtqdDdUeVdjQm5yNXhNWWcyZVhLT2YyK2FpSjlG?=
 =?utf-8?B?SXpUS3l0YjhyZ01lMXc2T3hmQmlPTiszc1hQcGpHUjRTM21sUTFkenMrS09B?=
 =?utf-8?B?U3hkVWVOeHdhWG5vZ3U0K3RGRExsNFZUYzgwb2R3OFh3SWg3Mys3NStWU2hz?=
 =?utf-8?B?RmYwTXJmVTVvd3VGSys0TGNmMXRpbitWNE5ycDBzYWIyRnhSTmZDY0pBL1hP?=
 =?utf-8?B?Q2doQkVXM3R5dzd5NVhMMTRrV2M0V0QxbjhQTWg5STQvaVlMQmtzandxZVRk?=
 =?utf-8?B?VWladjgvR2IzTWZNVzNHeWlISDMrWlJTNGJjY2l6bmtVK2JVY0pkR3FmSFRw?=
 =?utf-8?B?OHRCSUMvRzh6M3dHTHJMOHpBZVlXeklEUHFFajV6eEIrMTlqZWtLZWlmL0dH?=
 =?utf-8?B?TkFsUHdpUllrWXlibkpsOXorTXNrZTd1VUtJQVFxajNUVUFIa2FYOHJqRmR4?=
 =?utf-8?B?ZE9md3BoSjZjRk9PWUhZYVBnanhNcXE3d1Z4M2pXSEhlcjc5YXk2MEJmaUhS?=
 =?utf-8?B?dE1ZanZKNHNyTEYyazh4VWY0T2ZOK2ZCQVFBTTZsZGFjQmRTdjVvekhjQ25o?=
 =?utf-8?B?eGZIaktKZVZzU01WRGpwYUZ2Tk9hd2ViVEVuN2pwU0dPWnR0QXM2eTRJY1Nx?=
 =?utf-8?B?YWlCVk5GVGpKaXRmVk8xZnpZd09Rb2ZUTXVFU1FqQ1dNS0FRemR4RXlpeGZ5?=
 =?utf-8?B?OG1Xa3JTV1FDYXp6bXNremIxVWZVV0pJZmV6YStaMk44cHVQdVZyT0FMakU5?=
 =?utf-8?B?emk4c09RZDFpQllweCtMcVBWR3lWTmhUR2RWUWpEZWdTUHZsdHM0dWdsMVN1?=
 =?utf-8?B?TEtvK3pSczN1N2xyODQ3WlowTm9vRXF3dGhjK3c2T2dteHNVczVzWllCTlZs?=
 =?utf-8?B?M25mU1pzVFd4K2hMWVMyS0pBWm5TTWtFZzhMQ05VaXFhb0NTU0J3bHI0Qm1k?=
 =?utf-8?B?RXpJeDhaMkJYcUk1M3RjNFBhWkpjek5xME9ma2lFZDFOckJHbnd3T0ozTHl4?=
 =?utf-8?B?T3RQV0MyQUdGMFBBT3lZZ0hnTjZ1TFpCVWUrWEtmRlBDdDliNEkxM0dsdXdE?=
 =?utf-8?B?dUNYc2x3clhZVWFJNkE4R1gvUGJvWHp3eUJ2V0l4Nno2S0FoT2xrdmkyZHhs?=
 =?utf-8?B?NzR3akpmNzFYZG5QUWdQL2FVc084d3pOdjhYR2lzY0ZtV2ZSN0ZFazVnbytM?=
 =?utf-8?B?bU8yVjVFYnNyMXFsNGZHbmVDRkhkRHk0SlNYVjRFL094Y3k0bFdOeS9HL2cx?=
 =?utf-8?B?dWxRK2kxaUd4SzRwME1UdUQ3ZlBWTDd6bXFqblZ4U0JEelpmUzdSTkNVNjRi?=
 =?utf-8?B?YVVackN4STR2K0RPdVkrYXlrVnpUeFJDbCs3YlB5TjVVdVNwNjFGd3djYm85?=
 =?utf-8?B?anIxR1EyeXI5bVNmOFhickl3ZDNHcVBobG12QWZoekY0d1VlZ1VSZWZaQW1q?=
 =?utf-8?B?WTJBR0ZNN1VMcnh3SXUyVE5rY0wzMk1xVVBUcWU5Mk1kYWpzS2ovc1Y1OElu?=
 =?utf-8?B?UDA3Mnhha0hYclRPV2pvNUF4TDQvcDErMi9pblZwZm1JckhGREVzNHBMVEs2?=
 =?utf-8?B?cVU2Z0d2Q2dMTjI0OTJscEIrdmxyVUtNVVluRkxuNE0vZXFoYitsVC9qOEpv?=
 =?utf-8?B?QUhkamtVMStjWkFkT3NPbitYYnE3SXJ1WE91bDZCR2J4ajBEMkY4WVcrOXE5?=
 =?utf-8?B?ZWtpeWs2SEdDQk1jMVBFYWZyaUtzM3RzQ2o2V0N5VVBKTURGN042bG9HeVds?=
 =?utf-8?B?cTNZdGFGYzdxZEY1N2RYa2JQUWxvWHExTG5CODFHZVJkK01ZcUtjaTFhK25R?=
 =?utf-8?B?QVpoTVFVb1JwU1F1Kzh5a3VSeDdETHpsQnF4aXl1SFNsaCtCQksvaS8yVkFn?=
 =?utf-8?Q?vtoVzFYavR92x7pwUsHOYbK6vP82cM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VVIzaVhWY2l3b1ppa2M0SGtoT3F6cTVIemJFc0dSMDNqSUthaDUrUUpJK1NQ?=
 =?utf-8?B?eXhGem9yVVBLQjJNOVhBbk9UNW1mS0pISkpoQld3dWVjcjl0bWhKeGl3MEoy?=
 =?utf-8?B?N0tLb0taQlM3ME8vWGhuNGphK0JlSXNZZmxEbHhsR2JYTWRYbEFmWDJ6RkxB?=
 =?utf-8?B?RTFINVRtNmdKU0Mza1YyZkZWRVRLUmM0STFxWXg5Sml3UytZL0tleWZKWUdQ?=
 =?utf-8?B?d3R0T1NtcDZFZEZrc00yc3lmaDdiZi80KzhpZy9MMzVhMEJpZHZiclRua0Fy?=
 =?utf-8?B?bm93UW9GNXUrTGlxN3NwQ3NUV0tnbmNMUHZnZnhXSUt0cmIvYXlaRVRvampS?=
 =?utf-8?B?TzRZay9mQWdHOU9HOENETVVCYUgxbjZHZEVSUmFrOEJ3b2Rtc2lzQ3c3aG1p?=
 =?utf-8?B?cHFLZElJV3RMclU5bnhoN25RYmZ0S3dGdWxjSVBpNW1NNzFyZVVmMDZKWlBv?=
 =?utf-8?B?RmJHTHB4WnlpOUVmeWdTSW1EeXpWVnU4WHhBUmxkQldQV2ZJbGxlZ3N3M1Bv?=
 =?utf-8?B?ek5ObVQva1VFd2VQWVRGWFN3SmtNR3YwbzB2TW1wK05odnVqOFA5Uzk1akh2?=
 =?utf-8?B?Ui9nWS9va0JlRi9kSk9DaEJYeVFyK1QwVWlzdGlHUU11QlpEakFyaUFZVWNT?=
 =?utf-8?B?N2Z6dDQyanpKNlc4OWxxZ2theTk3QTZtRldVNEEzcXVIWjdXSWlYNXlXOWRs?=
 =?utf-8?B?dFd1MGdCemdoT2FLWHF2cWhsaWFYRjdFaUZyZXJqU0M2eFJDTzAveW5oTllV?=
 =?utf-8?B?Y1pjcmM2NUVNYnlvRWVCZzV2S3Q5OTg3MUZnSEpTKytFR1VUc3g5cUNTeHBO?=
 =?utf-8?B?clE3cDd5L0R4c2I3eStpTFd1akx4dGIyMU8wQjlTWHdKMWVTWkV2a3JSL09I?=
 =?utf-8?B?UFJ1R0lMVE5WOHRCWnFVMnpYbmhpR3RRRmFtSVVpbkNnTG1wSWpvU0xDeGND?=
 =?utf-8?B?UTVqdzRSNVNzdnV2S242bDRSR2FqTGFOU3V5OWtDWHZTUE1tRHN3YnkwUFg1?=
 =?utf-8?B?Q1FIY3J1RWgrUGY0R1BnRVhNeXlzVEZ4VXp0aUE2QVdhK1hnZkpTclRxdTZ3?=
 =?utf-8?B?cVpiWmY0WkhhNkdQS2dwNXUycUtaSU8ySFRudWZKMXdaK1FiblIzTWVISUNs?=
 =?utf-8?B?UFVQRk01eFlmU3BwR0EvRGpQS2I2TWNOR29TVjdZU1Y2c0NMU2w1WFhybUdx?=
 =?utf-8?B?MVN2eW4ySDJJYU1VZURHVWZwTTF1dHY4b3FQeWpoak8rMktnSUJKdS9VMW94?=
 =?utf-8?B?cnF6ZFZZME8waUdyek1XOFYzS0tzTE5YbHBVYzdQVUYxVDNnellTR2JBazE5?=
 =?utf-8?B?RHVqWWdjU1BNczFwRXE5WHZtRlJlN0hzK000MWsvR0gzNnZYZHJ4TnZRNmdz?=
 =?utf-8?B?KzV3a1JERmovbGIrQU5FR1RpVElGQ2l0S0NyclVGRDJFUUtMeVhlazBZT1Nq?=
 =?utf-8?B?cEFIUjJNcHNlRVBCS253S1FPS0tPQ3lrRlQ3NkxyWHhmWFRQVWFVcFZ1ZEJW?=
 =?utf-8?B?VGdYOEFiKzAzTTFIQllUYlpid1JJM2s0bEg3RVloMnphcTdaU2RxblJNWGpM?=
 =?utf-8?B?dVdlV1hyUzJuSUdXKzV1bVpSUURiWFNmdE54Q3RTR1A3M1g2S21KNE14SWtL?=
 =?utf-8?B?a1lTQi83VDNLVGNzSmZ6NGNxS0NaRERwdllYUkFSQTB6ZENIWXZuRWRCcFlI?=
 =?utf-8?B?aVhBOU1FK2ppblZ0K1VUV1FmNG82bGRXTWxYallybk5nTHdjQjdhUE85Mnl6?=
 =?utf-8?B?K2NCblhkamx5Y1NmQjl2amhoRXQwNUd1OERkbEJDVVAxU2lZUHpNbnBWbFF3?=
 =?utf-8?B?clMxSVBjTkQyY2k3QzFXaHppY282T0RXUHhadnNvT1V6YTdtWTdJcWowNXFH?=
 =?utf-8?B?ZlNicXcvZmlTWEtBdXo1TjZlMENnbE9zSG5sY3djTHZVNXp6c096eXA1RHkw?=
 =?utf-8?B?cWZPeUFNWTUzWlBoa0l6eVhBVW9WYkg3eDZsaEJPck02dm8xOVVHbEdEQTlk?=
 =?utf-8?B?VmtFbUZBWm00T2x4b0lyQm1nV2s1cVNocEdsOXIvdzVpT3owTHF6VERmUjJD?=
 =?utf-8?B?WlFBeUhvVTFPbW1zUUZ6VFVCUU1RQlp4Q3lRM3Y1Q1M5TFFuWXhqb3JHZlRQ?=
 =?utf-8?B?b2lNWTFPMVJpY1NnakdrRS9oaDNuMC9vaWpaYWVabWV0eVo3SGtEaUhmazhD?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4094FFD98627524BA2765C244142E43F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rliKqP1xRjgJB2MFcJOzpzcCvklshSyyFKS1aR2oQNmMZVaw6m3M50+irhNxcPlqttDgMyuZr0OZO+QOznlaNNIKSoXCk6DYidhSJjSvLBRE/SHiABc2IF+eYOjwywAetwOLoOYpoI2Yv7BeKbOXFiAMJVVcN009cPEhja1uLXFtSFHRsFsZOjy2Gyeu0t3r3k6JbQXtlgsCCWSMq+z1tMDLrOmiQgr8Xi/2E/TNVjPfNKZLAdV3AK5M3SrUV5nkerYOEpUPFwNRxFz6P6JgC+kdzHyW8ntj8Q6eshdH2FzpqE5P1YQIFwa3L+7zizETX4GS/tpmlrxICRK2B44DthI/cy98Ue5yNE8wZE6RDDrTp64Q1In0NESw8+R94YgHWsCgp+hUUyQ8t9IM4QGTmDUmbyy5NXp64GsD8rHhPGUMAJR0RqZytXACVIPXc+n8c3ypCOdRzXau4Xd0MNcwliBtzdQ71+j7f1ck/1EE7FGtgumM3ePsCEacJzdC4OZcy7Vl5TzJfECfgKG8eBHFAEMD05d3A8KZt7AkHr7b8OSlzVjWQ7oInXjm7irwLNhjzxl3HPrHZnVVIiPQbG6RWG9rlQiK6EK0/JPrA+l1brv8XaA5u4CscB9luWK9hxZj
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1ea3c9-bb1c-4778-50d1-08ddf4553ea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 12:41:51.6386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: clAHNHI7HQzm1iF9ab7xtwVQwIpuEGCntajrqRzZuyRF5LA3/yPlO/iYZtaoFTbcEU9Lru1GfNg5ZsKka5KuvGRrUJle+7yjhCXNysY4MlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7382

T24gOS8xNS8yNSAxOjU2IFBNLCBZdXdlaSBIYW4gd3JvdGU6DQo+IEkgd2lsbCB0cnkgdjYuMTct
cmMga2VybmVsIHNvb24uDQoNCnY2LjE3LXJjMyBjb250YWluczoNCg0KICBidHJmczogem9uZWQ6
IGxpbWl0IGFjdGl2ZSB6b25lcyB0byBtYXhfb3Blbl96b25lcw0KDQoNClRoaXMgaW4gb3VyIHRl
c3RpbmcgaGFzIGJvb3N0ZWQgcGVyZm9ybWFuY2UgcXVpdGUgYSBiaXQuDQo=

