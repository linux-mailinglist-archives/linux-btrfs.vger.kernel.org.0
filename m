Return-Path: <linux-btrfs+bounces-18025-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D0DBEF850
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 08:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BFD51898DB3
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 06:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36C12D6E77;
	Mon, 20 Oct 2025 06:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HFw4YBGJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="w6Hj5FlN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AB0A59
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 06:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760943134; cv=fail; b=BKys9+HTez1tBayHPcgoxfRgqfV7dlfrG0wx+rPxtgoShpClU04a8kYJG4iX+nvEji6/JMY+qy1WmXjlKdLrAxv2XR+szJrYGhQCjYHMa8WXOMcLCMn5XyGwiQofKPAaI45as0Z90UttfgPusNg1J/IhAy79UosxkJw/uNkpTLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760943134; c=relaxed/simple;
	bh=fLfDG/Ojz/VvgGpBPs5qQJ/35eBJfvlH99y1C4tmSbc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gtf2dFpOL0Dl+pmKnZ7T/OOjlu/omFG0X2jiJRRh9hOeqMoz63dXxNSsrUExCbjfDh82VjpdZyxelS50lOk2Lu+qGphRKva5mxTu682aVE1/1hfW/PApDSer1uGE6B1u4tzYcjroXLHHB7NB7jdErwpqn2qlED9Lbxmh5NhSC7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HFw4YBGJ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=w6Hj5FlN; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760943133; x=1792479133;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fLfDG/Ojz/VvgGpBPs5qQJ/35eBJfvlH99y1C4tmSbc=;
  b=HFw4YBGJGQhrfis1K/RODLkD16M1m4q+qzbNjWAUGJkmNonUGwUIwy43
   zxQ14CmbNiEJR4cPW/H8PZt+hPO0BXOUdfiIRPEfboM7DU6Q1ymk7xU1/
   mSd2xYfgFC6bvnmM4lgrUT7XhWcJEATu+Lee6YQ6P2aZUhPD4PCCjHOAQ
   yz4THBtwRx4bu56XUC7k2pApTM0a6QJQXJCRfRWnqUTIHP+5rFyyO6HE0
   0UttaJbfMEjzW82CF/IYQtFQtI/EHnj2phWKyXQIWFYkCxz9NGQ6TTXMB
   6/robrI8VifGlfWR0KtvUlLHhT9YCSPowt3XTSaRK3dh2TGy99QdE8tVM
   A==;
X-CSE-ConnectionGUID: ri6Kw9iWQr6NVHtxyjAqRQ==
X-CSE-MsgGUID: 6aBBKI7eRLuap/mWXCPzXQ==
X-IronPort-AV: E=Sophos;i="6.19,242,1754928000"; 
   d="scan'208";a="134789790"
Received: from mail-northcentralusazon11012017.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.17])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2025 14:52:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bA2u9JNLd0kMNtgw+bZNqQvKLI/4hmkDrJVZj76iyI4Yvc9mYnpuqPdePL3YY2QgaDAk/Hzd/VIKwtpY0RxDBK2NPx7QdsIPXuhCguymlsVwt1T7oM7jGpW+fwR8PBRLbzH2NLq/McLmgiTv/XdObarp8XvzfdiUncgJ/kk4244/3O+k1nzql/jP1uct7+ypETEbgKUN6/rYMtrLO2/QjFRIPvCJJ4emiUwrrMnf+VbIQb1QrvXbLlgY2mCuEp6J8WIZhNelyY0tvTzBzvPSkmcvHoYihPYCz6hOr3tH9GoYGZdfQ54CGIHgJvXsobqJgjEj5sy1CgVUJd4dKUonzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLfDG/Ojz/VvgGpBPs5qQJ/35eBJfvlH99y1C4tmSbc=;
 b=WP7+qArPWIQ+1pQwvvbzGkJ6gwgBHmL4iYZUmxJsUr+owCZxbhit9UBXep1mIOnMXck8WL4s6SttCtDZjdVgD8uO3M9/AIcSIl82w/QF20yu19rpC5n7tP2fiehLzb5GeTr9FbJmil03z9v8nXB+FFt8jLyLvC7CqgC4n5c7otYxYryaYmtdUO+vVI/3MO8PSqfNn9bCMzU2Y9T6ib9DkIMaYCmzUv5zQdAehFoFUCA2R1IY6R3nO5iVdHdAvyAVoxSIPWGY6nukMuvsxV9hM8Zq1K+0mGN+2mK1g95adW9/iga5MlacVmx8DFvCFLcBvY9tko9v1FcpWbNyFSe2fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLfDG/Ojz/VvgGpBPs5qQJ/35eBJfvlH99y1C4tmSbc=;
 b=w6Hj5FlNaTr8cU+Uvyy3HmUku92dYq5Z/+8YXGCmCZKX/jIPRflyRh4HrEVIEP0Zi6Cyrj9wKacO+9X5LzCTPBSMp3TmVIbwmayD1ZDM0XAQG5VW0g5c0Hw+4BKp3O4DOz94dEneqEfSqN2QGbDdYbocY78AibEQTcHLWEZfyDQ=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SJ0PR04MB7360.namprd04.prod.outlook.com (2603:10b6:a03:293::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 06:52:04 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 06:52:04 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>
CC: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: zbd/009 (btrfs on zone gaps) fail on current Linus tree
Thread-Topic: zbd/009 (btrfs on zone gaps) fail on current Linus tree
Thread-Index:
 AQHcN1KuGCX0HNOhIkayN1jmYD5sCrS2iOkAgAE6w4CAAAEogIAAhrYAgAwao4CAAgBTAIAERZsAgAABVQA=
Date: Mon, 20 Oct 2025 06:52:04 +0000
Message-ID: <506e7292-d795-4a78-9c0d-8442cb3b7a15@wdc.com>
References: <aOSxbkdrEFMSMn5O@infradead.org>
 <e0640c83-e600-410e-bbcc-4885852389c2@wdc.com>
 <aOX-g97die1kbVY7@infradead.org>
 <c5b15471-5a8a-4e0b-a7d5-ad682785b581@wdc.com>
 <a2c698cf-5735-4ef4-859b-057fece29c9d@wdc.com>
 <aPCXz7ktsyE8BLeG@infradead.org>
 <f141df1c-1d91-40f8-853a-f423ea4a452f@wdc.com>
 <aPXa9gR4l3WnI8kh@infradead.org>
In-Reply-To: <aPXa9gR4l3WnI8kh@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|SJ0PR04MB7360:EE_
x-ms-office365-filtering-correlation-id: c175d73e-b3d4-4ff5-c45b-08de0fa52daf
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|19092799006|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?bEhUdnl3VmZQK2NNWVFuWVRNM1B6dURYc1ZPekN0UlZuR3pmQzRhUXBTRFhX?=
 =?utf-8?B?M051QmpKUVVxZkw2VDh1UWUxL0pxNHFzSE0wNmcxTldoejhSVTdzaXdLdTli?=
 =?utf-8?B?YU83REV5TlhiMGNXeVJrSnVuYWVDc0EvWFhQd0c1cFFuOHh4KyszaGcyOUlF?=
 =?utf-8?B?SHluTzJ4QzV4TTQ1TlI3WGRDWjRnbWM2SVB5M0QxZlZVdnQxM0JjUTV0NEQx?=
 =?utf-8?B?UWlqWlpKN2tTLzRkek5kRFV3S1JBSzBPMnJkV2ZtMEFRaFV6dUE3SEh5Y1lQ?=
 =?utf-8?B?VjFmWlFxVFZyZ3BsMUp5UGI2dGtqMFlHMHFjVUdhUzI0d2NlSkI4SVZuT1hJ?=
 =?utf-8?B?ck9heTZ2M0xNSkQ1NzRULzFKZ0xuL2RZUFgrQ0RHalVXSmpIU0JwOVlxWjZH?=
 =?utf-8?B?T2lTU2VkMGV4UUZ1SlI2YWVNZk1CVFYyNDgvS0RLcHYrUlFlSEIrUjlnQ1lq?=
 =?utf-8?B?VEFSaEdVRDNZaTdIci9oNldqM3ZFTGRHVC9JSm0vZ01SQ0FDQUgxVlpjK3d5?=
 =?utf-8?B?OEVoMnppbldhblBhSWRLalJINnVYQlJEeU5kUWlaWlNodm5JYzlRNXRHUnRV?=
 =?utf-8?B?VGtRa04zcUFPcGp6NktvcVUybkI4eFBTbzhKZ0dqbmZaWXhmbk1kdTdna0lX?=
 =?utf-8?B?eWJBd2hHUHBRcVBmWW5xdFowclMybTZGZ2J2VGgxTmVWaXFOb1l1a29COWli?=
 =?utf-8?B?azJMNkpNK0ZQU1g2RGFkdVMvWGlhNGlDMzBDcUhHbmlFbjd4WDI4TGFSTEZP?=
 =?utf-8?B?ckQ4d1RNei82RldPRzVkNWduUTE0QTBDY2lhN0dTWFZOcVB4ZUFRS0JZR0F2?=
 =?utf-8?B?TzBreW0vVHV5QkJOZExONlVhV3c2SHd2WU9CYjJUa3V2c2l6SUZQalhSM1B4?=
 =?utf-8?B?WFlGNUtRbDZMRi9Cd0ZiU0k4Wkd4dWp0MktUL0l4ZHduY2hQMGpmbUlXR2wv?=
 =?utf-8?B?NS9XTW9EZENZTW54b2VocjNTLzUyRlNEZTJQcjgyYS9VL3kvZU5XWmpXN2tO?=
 =?utf-8?B?MkRJK090WE1IZVVVdG1ZM0JhRVNacUJGWTRUd2ZmWW9VcVNXL1hqcno3QzFi?=
 =?utf-8?B?anJiRFFpRG5FVlhzSlNBSXFUUExWMnFyeC9pLzRycUd3OUxaRTBvbXcrYkw5?=
 =?utf-8?B?QWswVGJXR3JBVFJwK0QvbmozNCtQMDlnY0hnMEEyUkttT1RiQk9xTis1VGF6?=
 =?utf-8?B?WloxUUNGUDExYzAyWU54b2VTQTVoS1cvSWJxckRicmRXWmlyVFh6aFRqb2dq?=
 =?utf-8?B?bHErLzVLYXBXR2tvQXAxc1Jpa21JandWaFErZklJMEFuL25QR0MwK3JrNGh1?=
 =?utf-8?B?bHhZYUlZS2d5eUd6Ykx0RjRrUVZKNngyaldZQUw1bmNVejNjTjhrRkVYQk9J?=
 =?utf-8?B?SnNzYXowVE1jREpNaXBiMnFwNUdQWWZBOXh2anViSDdlMERWVmxlVWxlL1pK?=
 =?utf-8?B?Tjd1cUtPbzQxVUhVeHlBNXFnd1l6MlM5bkJFNmJxaHZpSVhxRDM2aHRNdStC?=
 =?utf-8?B?eTFnMVVOTXhnd2RvRllvc1I2Y2Fhekw2aXJZazVoemdYMS92aDRwOHRMNDVS?=
 =?utf-8?B?UStTL1Y4L3dBL2p1UVBUSi9MZmYyNkh5TnhPUmU2bXB5TVFvckd3alFWWGhT?=
 =?utf-8?B?ZUduQ3dLK2R3TXpncXZwZzBnRnpXQ1NJbHNqeHd6VGJKNm1KTWM0Zkp2TXdY?=
 =?utf-8?B?bXhCa2tSVURZWm0rVi9uRVo1N00xZ05MNGV0ZHpwS1o3ZVY5RUV1NDhucm1u?=
 =?utf-8?B?eUx0b3VwekIxeTRjTnM0UUFDWDJmRjNLcEIxZ0UrN3BoR01JaGQ1d2NwWk45?=
 =?utf-8?B?Q3lPandsY3JzNlQzSUxJWWZFK3FmeEs2OFdOMjBsVERUMjlGQkZPZ3N6K05V?=
 =?utf-8?B?aDFKTDIzbHdac1JmM1JlUnNRK2F5Ryt4LzNvRlY5UFh1U2ZHQys5Tk10aGJm?=
 =?utf-8?B?R3hhQnZET3VaYVN6YVp2TUxCUmZ6V3NSQ2kwTEJLMkpBbzU0REsrOGY0cnIv?=
 =?utf-8?B?c1I1RkJCWW96MjVOcE8vVGlaSkYvZ3BFUTlJQlc5eXE4UDBLN3VuMUs0TDFC?=
 =?utf-8?Q?V6OhfD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(19092799006)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d2hwb3pQUDlPWkMvUFcvU1BBWkd3SUg3eGZ6V29hNkFCei9QTG1LcXk4TDVn?=
 =?utf-8?B?Zlo3T2lkMTdRZGM3WWw5R3BDUEZ5SGo2bEFiTE9TSTY5R05uei83dnIrb2pk?=
 =?utf-8?B?WEdCam5pSVJOdVFZS2xQOFNoSk5LZlZvUG83Z21IOUlHNG8zUGJRdHFzVDhU?=
 =?utf-8?B?YU9ZUVVMRVkvYkd0bFpLYTNnWW44Ump3Wi9lK3JmVzFGU29XR20vTkthZVc2?=
 =?utf-8?B?V2xodkNNWnVoeElhWSt5Z1A0NlkzaTJobzhWWmN5QzhvalFQdHJZZjRQV0V1?=
 =?utf-8?B?aDFGeFhxT2xQSGVqT3F2MHczdEhTUUFmbFJLNGJqMmNaVDRaUkNwK3NGb2hq?=
 =?utf-8?B?dlhPeGowdmhBcE4xREpFOEpFak1OT0c4RWV3YWYzMjNTTzlzMGVkS2wrVk53?=
 =?utf-8?B?S3lTaThZU05DMVk1TlNXUGIxbU5vU1lWYjNxRVRON1VlRUg4N2ZxUGlmQ0RO?=
 =?utf-8?B?TFlhSG1sUUZHNVhzUmtJOXJTYytZNUJsaWhpY3hJV0hhWGQ1VmtqUzBTSVds?=
 =?utf-8?B?cWFqb0gyR01Ec09TNm8zNE10MmJ5L3B2V1prcHVWcTFXZ0pjTGV4NDYzNDV0?=
 =?utf-8?B?TG5EMFVUVEo5MnRpMGZ6bnFDRFNpcXJwQ3JVcEMrZXZsVW5HRk94VFhsWitV?=
 =?utf-8?B?SllsWmZYVWo1b0VRREErRCtZMElrZWlDdmY3TjFhWFZMWEgrak1pZXN3N3dq?=
 =?utf-8?B?VndEZWhzWjNRWnlWUDVybFZkVXU1RWVPTVBhVUNtSjZnU0k5a2o1QnBsSE8w?=
 =?utf-8?B?eExzcy9Oc1NkVE5ydTVOMXd6a0c3MG9CVTRLZVlHUDZXY3BEaGpJMzNaaDBo?=
 =?utf-8?B?K1Rmc2EvRWdFbUF5SEExNXpON29YU0orOTVoTElwaWw4T1Rmc1pOODg2eDVS?=
 =?utf-8?B?emlkZEthSnhheDBGeVdTTUxBcnFNNEE2SXhtcDZiWUFVV0tsN3VHRDhNbWRx?=
 =?utf-8?B?WVZlQlM3ZEZhaG1RcS9OWWZ6Qm92a1JQS3FMRWMxYVMzK1NwSGFQUzdRbGFk?=
 =?utf-8?B?VGJlQUIwVHpVRVBGWFJWQXphTnN5M3UzbVBKbFNJVVhwZllNSkZjOXJnWWFk?=
 =?utf-8?B?QkhSUTBWVkd2OHowRXlCM1FwbkFPcXBjMFJ1UEgzSkNscUVkamVoSmVYb3Fo?=
 =?utf-8?B?VkJXTlB5SjJKNk1UM2ZCZEhtRkZFV2FHUW1rbC84dUI4Qm9ZcERsZk5UUlF4?=
 =?utf-8?B?MnJaRTY4Y29URjcwbU96VUhaM0NKYU9CdzJhdlRrSzE3cENJaXBHakJVVXlU?=
 =?utf-8?B?WnBqbUgrNDRBa2RoMjhRYnpNYzFSY2w1RGt0aXlUaDRLaFVySWlxSllsaGxw?=
 =?utf-8?B?V09QY2pmVlYxclNYamJOMDdIOTY1cFNqTVJJdmdkYjl1c1llc2lrMFpXZkF4?=
 =?utf-8?B?cERBL0d0NHZQUmtzTm82bTI2WWhjVGZsSlprWlhrVHBiemI3WUhNZjFPRkhv?=
 =?utf-8?B?RENqbWJ6TDk5NEVwY3BwUVRkeVY3MkRxeFB0V0lnTTZ2V0x1blFtRzNUSzlp?=
 =?utf-8?B?NjhFelBIVjFCUGlKa1I5UDhnRUhQZXZtZEVYR251WXNQZnNHTTRQemZBTTB4?=
 =?utf-8?B?QmtNWFhDd0cyRnRjYnBXSVRTNTZPbC9PZUZKY2ZES1ltM0RUZFpzNEdaazlp?=
 =?utf-8?B?RllWL1VJT1hncVFSREc1N2NhMGtYUkFlZTRCZ2oxdm83ZzZuWHFPeENOb0Iz?=
 =?utf-8?B?cWZLNUY0SjBzVi9YbDRpb3RyV3Q2cEtsMmhHWTRiM0lmYVNCQ2VMVHFlOFh6?=
 =?utf-8?B?UzZ5d1c0OGU2UWNzZDIycE5kN0JRRTkwQVI1SXhId3g5eGF4ZHQ3UlRuVU95?=
 =?utf-8?B?TlhvT1Z2Yzc4aCtJditHUGZpbGUrdDNyd0VNL1hMbnN0eEpoYXpCTHpRbi9J?=
 =?utf-8?B?QTlvRUYwVC9obUFlWVBEbGcwU3RHZWZ1dzFGMDQ0WUUyMlFHWGpvZC9tYzJx?=
 =?utf-8?B?MVUwZlVOVERUQ05ib3FuOC9GZ0NFT0Y0OG0zRzR0YVQ4WWpBbWU0UjJzK3g2?=
 =?utf-8?B?eGdZejJrWW9QUy9sTzk1VldOdFErZ042eGtrTUpjK1lyR3lPNGFPVWV0TTh2?=
 =?utf-8?B?cGlMMGN0WFVscE1ZRTArb1dhZVBpYU5ZUVQrclJMTmtCSHVFVi9NYzNUM1NF?=
 =?utf-8?B?VDd1N3dtaTN2UXhIdWQ4UXhqSTMvVVRqYVN3NE9hU1pIUjF2bGwwQ2gyb0lx?=
 =?utf-8?B?WU15eHpwVmd4UEd6SC9iNlJOR0pzWUdUUHV1VW5iam9BUWFINzA3b0NSRHpy?=
 =?utf-8?B?TjZFdTQyalNIS0JocXc2aGJOdm1nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A7EB229A129AD4AA979FAC7D8DB0E16@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O0JV2zdyZVL7VnzsGAaVCpmwP2JHAXFcREjznRl+P5JuAWdCV+AjPfEiFJCxo2KgyFrA41TCBRdkOXXFrMJtLcYTObwFdO9yzt4E8u6Aztom+cDV5ljW9g/RY1kdY1RHOwab4D3V+J1yp5+t0XembeJMkLR6ortpyvGsQlH6CbA20wQ1JPCSXiwbdB1OJYiypTzFJb5kjcfY7YCFZXz4bt9XaGRAOZdrNW62prld75IXNs3Z5hK1o9eAjL6AwnAjRY9m2Sj44jzpVGQJm5a/gyWj0P6ds3YLbnp3MMqH/dRmzwmHZwzL3bhYR7i3aT+db5OtzOclGnw/+3JRJ0keWmIIwI460FYM49O+DQdOMb/5Io2HADExTnJHSZtgtVB8M7NmukhZbPl6eyqz0Lam1u1hTPl9zDTm8LcSUNf3+lRpzK1yWdbwMRA3GZlezF+QkO2hbIkeimEsuxEShtcM5WAQ+KHtvwJIpX0WQJEmr2dIq8CbmihDI1V0lloG2Ia9km1CHAnytiEY4icOfwq9+eHuNNvyUybY9Hhf69+QJ0wADdHHNtfF6QGVMz7IAxCuy3gaj4XmfcQUfUBY+JN+7hbvh9J4ykq2mGF6rEBkqIOGE+fTN1Q02kujFPOWR3n1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c175d73e-b3d4-4ff5-c45b-08de0fa52daf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 06:52:04.3313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BWENgwJQIC+Z7pogGYItSpZoDEpdrCmULgm9kTT8vTDpU035HYA0cz7UsNsqUfjZVp7Sbxci1Pv1M8WX2MCv0aScSSvewVw4S11ATkFdIUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7360

T24gMTAvMjAvMjUgODo0NyBBTSwgaGNoQGluZnJhZGVhZC5vcmcgd3JvdGU6DQo+IE9uIEZyaSwg
T2N0IDE3LCAyMDI1IGF0IDAxOjMzOjA4UE0gKzAwMDAsIEpvaGFubmVzIFRodW1zaGlybiB3cm90
ZToNCj4+IE9uIDEwLzE2LzI1IDg6NTkgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPj4+
IEkndmUgYmlzZWN0ZWQgdGhlIGhhbmcgdG86DQo+Pj4NCj4+PiBjb21taXQgMDQxNDdkODM5NGU4
MGFjYWFlYmYwMzY1ZjExMjMzOWU4YjYwNmMwNSAoSEVBRCkNCj4+PiBBdXRob3I6IE5hb2hpcm8g
QW90YSA8bmFvaGlyby5hb3RhQHdkYy5jb20+DQo+Pj4gRGF0ZTogICBXZWQgSnVsIDE2IDE2OjU5
OjU1IDIwMjUgKzA5MDANCj4+Pg0KPj4+ICAgICAgIGJ0cmZzOiB6b25lZDogbGltaXQgYWN0aXZl
IHpvbmVzIHRvIG1heF9vcGVuX3pvbmVzDQo+Pj4NCj4+PiB3aXRoIHRoYXQgcGF0Y2ggemJkLzAw
OSBoYW5ncyAxMDAlIGZvciBteSBjb25maWcsIGFuZCB3aXRob3V0IGl0LA0KPj4+IGl0IHdvcmtz
IGZpbmUgMTAwJS4NCj4+IEkgc3RpbGwgY2FuJ3QgcmVwcm9kdWNlIGl0LiBXZSBzZWVuIGEgbW91
bnQgZXJyb3IgYXMgZmFsbG91dCBvZiBpdA0KPj4gdGhvdWdoLCBjYW4geW91IGNoZWNrIGlmIHlv
dSBoYXZlIDUzZGU3ZWU0ZTI4ZiAoImJ0cmZzOiB6b25lZDogZG9uJ3QNCj4+IGZhaWwgbW91bnQg
bmVlZGxlc3NseSBkdWUgdG8gdG9vIG1hbnkgYWN0aXZlIHpvbmVzIik/DQo+IFN0aWxsIGhhbmdp
bmcgb24gLXJjMiB0aGF0IGhhcyBpdC4NCj4NCj4NCk9LLCBtYXliZSBJIHRlc3RlZCB3cm9uZy4g
RG9lcyBpdCBhbHNvIGhhbmcgaWYgeW91IG9ubHkgcnVuIHpiZC8wMDkgb3IgDQpkbyB5b3UgbmVl
ZCB0byBydW4gdGhlIG90aGVyIHpiZCB0ZXN0cyBiZWZvcmU/DQoNCg==

