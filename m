Return-Path: <linux-btrfs+bounces-21947-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJKmI4frn2nYewQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21947-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 07:43:19 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC111A1640
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 07:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1A14304C61E
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 06:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F4B38A73E;
	Thu, 26 Feb 2026 06:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YyqMsFyc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aZtpu/Fm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4372A372B52
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 06:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772088191; cv=fail; b=MzHp39N0EPypa4yZ0IoTD7/wvmqdGctDerLhjcVxVvc2i+RDW6KsZWJEOHCHeo2euQ69YtSx1IRHLruWF1UFkkRWaRtkEVdIMCE9+Gwp7X1FFInCirzMB8ojpnUfTMsLjiB2r4bBgTH8zkhsEPDAJOmMLHed7wROLqqLgfvSNJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772088191; c=relaxed/simple;
	bh=ByqtehsgFXey6vLUPCHQCtR1lszGnn9O6jhWT31I3t8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uUXhUoVLzQ9R8Ag8AO4ujBe0JbAGlj4WPTmraeDz6iL4dhAQot/SmtcB1baiKDM0s5qNSv/VrzwdK0xhunzimLES7AvUm+UFK4PyBdhp7+Qkl7xki1v2ArH2Rax9d9gOWgULOVNK8N++N3mKOwb9JEtUIsppk0jlz4Of0/gxQOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YyqMsFyc; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=aZtpu/Fm; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772088190; x=1803624190;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=ByqtehsgFXey6vLUPCHQCtR1lszGnn9O6jhWT31I3t8=;
  b=YyqMsFycFI9RFD1zriwVU1jtHRhQ69ov/ly6/Bl7ajqZwhW0LA49HGTb
   mvLyH9uhw/KdvKtrw2qPyqG7aKXLsCx/Yvmh4QLopRwOgrQh1uqoix4dd
   d8jAxYoo9rKj/jN4TQGwM/8VcT48FpHTviPMoP4AwB1Xtjmu72Rjs069q
   xSWj8blWos8Uj0iOn3A3TaxYJA6O1pIsHgd5XNv9IWkS3aj528NtUdgAU
   CSjXqI6mvulrQUVMB5eqR/dR28FuNc8rTZ3sbqEFytELIqJk0+rrMF6BK
   lB2cOaoMsRjMVOtHuIagd5WgZ7/dcQaWW12JBGyl3kRe5LfwsqrdCq+Zw
   A==;
X-CSE-ConnectionGUID: DmQ0K+K4ReOMa9D/FO4OKg==
X-CSE-MsgGUID: DXr7w29SQyqXewfRpFZRXg==
X-IronPort-AV: E=Sophos;i="6.21,311,1763395200"; 
   d="scan'208";a="140553629"
Received: from mail-westcentralusazon11010062.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.62])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Feb 2026 14:43:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkrWH3QrdQNMOVTM3vexu+a3HhQMQIBpbAIDkKMubEtUZcyPip3KeSdlh1vSk1EUhOlIVYRSDzPDynOMrRr2STru9tT3eVyZESBUMdZGN7a+cn41Y51k5lvfa4pzBQtRg4PIGt1sKklng2NcfZtZQBNCBouqSOqvhu0Dk0a1Xn+mKby7TRTZxGfVCICn3eJjXPaKDMM/KDPuOT054Iiz932to51aBtbu1o9MYHmjpQFdbs/BRwz7b37cUcSKg3SrjU2Ybrfezo10RTYgpJuxMyxaNDg6SmZCVdS4MPCFMR0Xm5NxUfnbOg1plIi2nv/SYMhbWNtE7Lx2FNy5PW4Uwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByqtehsgFXey6vLUPCHQCtR1lszGnn9O6jhWT31I3t8=;
 b=WtVCu+StWvkbeSuMJgu0P7XzSDXIks9fqFsjM6bk3xurdZprKpv5cYcOjsndMcJsSrSfgvJTE3xVD3dqn4pLR0Syrd64M4KVyKJKnrlDwm0Ir0YKnMkIWApC5NQMj7W+AZZecB2WwDvHf05Eeej9+xZ8ePBjuMA2A8KQnd9ZKqnsHwf6xhjuUnyW0USfLBhVgdWJmQsnOA7b4ijgByx7YkKT8kQMPx9huRYhesf+1eTDwUsg2JN70HUFiLRZAVWs1GoL9+usDwV/33O/uiUXHUWc5DqSMN46ahXyD3ymZo8AijvCv9Ct4sWbGxr4FEn/aIH/+ljUc+EUvXQeM2PY4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByqtehsgFXey6vLUPCHQCtR1lszGnn9O6jhWT31I3t8=;
 b=aZtpu/FmGkHn1znM1WTV7Sn+J2WvPKP0uYm2G0bnJcBEozHuPsWwPWk000WcSSCvGOOQOwV/TYHKs38rmKbYT7jqyB0/QjxBsruFwopHUsG7bBbHeinvU61dzRv/VkPCvTTtWpVlJNNiGJAHW8hrgAABwoT9mSobl+9+IYnwUI8=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by CH0PR04MB8065.namprd04.prod.outlook.com (2603:10b6:610:f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 06:43:07 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9654.007; Thu, 26 Feb 2026
 06:43:07 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: remove the folio ref count ASSERT() from
 btrfs_free_comp_folio()
Thread-Topic: [PATCH] btrfs: remove the folio ref count ASSERT() from
 btrfs_free_comp_folio()
Thread-Index: AQHcprXNz2cFcKOWKUqRx+tWsfyiPbWUiOiA
Date: Thu, 26 Feb 2026 06:43:07 +0000
Message-ID: <ea88634d-d52a-4eea-832f-528177e82321@wdc.com>
References:
 <30541df912ac4a2dd502796a823558fe1d88baa0.1772065237.git.wqu@suse.com>
In-Reply-To:
 <30541df912ac4a2dd502796a823558fe1d88baa0.1772065237.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|CH0PR04MB8065:EE_
x-ms-office365-filtering-correlation-id: 5ce766ae-f04d-4d6f-77e5-08de75024cee
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 pcJFKj8cPeOFBB9+isAT2maLOTsC4wQ2ZVgOGtCHqpuF7CCs6+QvzX8FgC9cB62fnXYQoNGTPHJq8CCB4VcSYXwU05IrBkcI/utPx4YjZWK4S1JKucMcOjTrp0p0r4Sycer8CANexyIfME3AJq2mEFRqrPgbiQEPDOK0zt2swaLG9NuRFPjeF7/qRoOcN3FMKGd3gMOK4T2XHIElCnjErvU1O5fLV2Zb+Q3rjtxRn91r+Mdm7jaBRUtw0TPuC8Nv5PTqaAkkIzxEbtn5wlN+1zA2EWvfo6jCfVotDvr+t1ZAGv9Dsoxt7IK4Gztru6TTKcjl3MeV8rEbEBBT9MUVlyn2ziQ8WKXffhOTqa7iLaabC/FoGwCpdXtf+HZXCx+E6loqejVPbKdRkjRuCQ65TzM+fU/lRF2P1zO+ZFX+bo4TeJTbI9AACNjdwl6TXfZ7HAOvAUln9s0ynNyYkC2217ivBzkcXA17zieeLerSkEFv/C7KlIYmCfmusjC0UvYz+tSbqGGWh7PxPdXWnym+tunEHWYbAllSYYut85KV3v8osajSIpNfzHONKhdUWGKRzSPtRUE8pNjEmQ9o1UStNe0jRzdCROsnftP6aT9WfYXOhJ0X3OkGZQSFYCxyRSsuJGPlPTVW7PIun+j+U767IHybK+wdMMp8IkD5UM9PWtg5D5e/qRbRRx1IoOpU3Sa1Hkfc4Da8CN1h5rTVQDEPArYlDK9AAsbfRNTJN/b0tn3cjI0XDQsnEB7jl2GvtJ5By4ZwpA0nrdmL3jLu36BeekNhgGj5gXM3reqiFlDEWuQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bUNrVyt4VHhTNUVTWHN5bDFMNzA4U3E5Ky9mMjRwajZPUXBrWVVKSU1rT2dP?=
 =?utf-8?B?czdrSndFelBCc1Q4YXZnL01RcE5mNDF2YUc1ektUL2RzdGRQTk1iZXNEYmww?=
 =?utf-8?B?WDQvRnI2Z1R3aUhER3JjWnN5b0UxUk5xVDBNQmxTdVNhNTUvNXhhVGg2b3B3?=
 =?utf-8?B?Z1lwYzN6bkQxT1lMVDlvUXhqNGZjV0RDWnd3bjFVdUVib1I5dmNhVkZrVjl3?=
 =?utf-8?B?d3hGWjg1OGN6Rkl4ZytUNnpSQ0paZGRCQkVpSGROTFBtU0NiSE42eW1FQ0Q0?=
 =?utf-8?B?eW1sNko4K2crNEJUellaTzd3Nm5HK0t6MkljbW56bE1BY2VWV0h4RldRVVV0?=
 =?utf-8?B?TTZZNnN2WDVsRVZQcUlpSWp1WnpTa3ROaTJMeWtWYXJvU0dnQXl5QjBnUEJh?=
 =?utf-8?B?VnlHdzZEL2lWQmNpK1BBWnNibk41VzVkdHBENDVMSUFiQnlvQVR3YTRuOUE1?=
 =?utf-8?B?a0lXK2lIQ3VxWG56VjhWTkZZR052LzF2d29BUFliNm1zSEtoZlBqTm9Wc2Q1?=
 =?utf-8?B?bGd6d2piMDRqT1dqRFlldFZHWUNQb0loSXpBUmJFekVMM05yQVpOM0w4d3N3?=
 =?utf-8?B?eFVxN0g5dlZXdmNCL0lETndJeE5ZekJHVllHYTltaW0rUEpJUmh4eDg2V2k1?=
 =?utf-8?B?ZWNaQ25kQ0ZTV0RqclFPNG52Z0t5TTVVS2daM2VHa3kzeEJzUFBXSmFxbTNp?=
 =?utf-8?B?S0FBcHl0VDZOdlIva2xkNU5leml4K29ScG5JdkpVTTR3YlZNT21LeUhpbDBy?=
 =?utf-8?B?cDUwczdGRFRMUnNFTlNESjBSUEdzL3JoRm5sR0VXWTllNUlWNzI3R3Q1RUtU?=
 =?utf-8?B?SUVPdWFIeVdCTWJ3VnNuQUhCenRwUnlEVkt0RVlwMm45VGdrRE1KZDJObDJ5?=
 =?utf-8?B?ZVFPeGl2T3ZrQUZQdDdBMEwxOVQ2OEJmQzY0YjE2YUcveHhaS0RoV1I2djEy?=
 =?utf-8?B?UVRwaUUyNGxiOVRZa0ZkTk9adnI3a1RUaEpXdDUrWHJvUUxsTkYxemwyWVhw?=
 =?utf-8?B?dFF1QkFITlJuSnFKTzlNOXhCRlJVOFp4NjZQbmVnQ09wRldscHpYNnRNTDFW?=
 =?utf-8?B?Snl4RTNvdG9veXZnSkJqMXRNSFJmVTYveTdnYXppT09iY3lKdVBZd1FFRFFO?=
 =?utf-8?B?QlZqdXF2U1lxOWxJU0FlcmtpbmlrSFViUndRNCtvaFJHamhmTHVuYzZtSXdl?=
 =?utf-8?B?K1pOdEFMaTNUOFdXalF1OGNrUm1jMXVMamhGMzRaOGpUcjJUallLMmFZYWRk?=
 =?utf-8?B?TkJZRllvblExT05vWk11dVFYNURMdElrMnpLZlVyR0tSdWV2ZE5NZFd4NVgx?=
 =?utf-8?B?RGFGQ1h2YXVKakhjNkhKK21aVzg3ZFRuNURoSHljdFBHamM1RXlCQ3lTWUpX?=
 =?utf-8?B?VVo2OHM0LzB2bVl4dUNzY2pBbUMwRzAxMWJhcHduNEFZcHA0NGFNT09oeEYx?=
 =?utf-8?B?L3JsbGZ2blVqVVZYL2IyRVEyaVRVUzlCQlYzTnova2FXbDhjN2pZcFRZVkx0?=
 =?utf-8?B?dW1Iei82a3NpWktraXRCb1E0dW9qU0k3TExaTVVXb09QaEV1U1lyVDhNS3A0?=
 =?utf-8?B?cDNYcU5HUVlZNjNsWkNydS8vcWsrQWFMTXBzYWpkVVpISFJaME9UazhIb0R4?=
 =?utf-8?B?L1AybDl0bXh1VjByS2w0Y0hMQVVIakhhNlExdDlTRUJ2YnRSMGtMMWd2OG51?=
 =?utf-8?B?T2JURWh0NmdhaUZROXBjb1dEUFZGdFQzR1BuU0VqVTNUVXN5WUdhdDJYbzRa?=
 =?utf-8?B?cU1MWm9KVjdack44Znp0dVA5UUpTUkFZTG54bVV2cVhJa2Y4SXZQemFKSkVD?=
 =?utf-8?B?aG11MWUzb25tS2RsNVpHM1l0eVFnb3BXMTQzZWo0QWNkTjhwY0h5M3A1ZndO?=
 =?utf-8?B?Wi9RQllBbG5DS2pQakFhQmZKdGluWElqSGtVaTk1VDlpRWx2Z0xUS2JkN0xi?=
 =?utf-8?B?MnlkNlBiM1QzbUNERXZzaVEvdFhacVBFMEZjOE1abXhOZ1BqUFpyaG0zNFNq?=
 =?utf-8?B?OGgwcW1JSTQ5cElrdGhWci9EdVRJRFFMZUpET0ZoejU5Q0xTa0pKODRNeEZ2?=
 =?utf-8?B?MW82clNOeGFBdjhVeCtsOWh5U29uOWVKMFJrOURrVlU3cC85T0FiWXFDSldp?=
 =?utf-8?B?bWgyQU9CQnFsb1hFOEVZZ01zbmY5Z1grVU13NExLL0drUGZnZzkrdy9sNDBp?=
 =?utf-8?B?dXFXeDVYNGRsd2FRVFZSaDYxUFFPc0RpZ2c3VWVkczNvbkdwb3VmWnhxL24z?=
 =?utf-8?B?QVNxU1lEWmVwdjMyK2VqbXQvbWt2ZHluSGEzMkRYSEpzSlpBMitLaHM1ajQr?=
 =?utf-8?B?SVEwY2srQ1hCd21LR1EyeGtLVTluL2RiNE50ZnF3N0FyVDBGQVQzcUVLWU4y?=
 =?utf-8?Q?wsYRfNZCzLJK/TXg58OjVViCiZmsVjLpsjrRCYHGPvEVd?=
x-ms-exchange-antispam-messagedata-1: Y0I8bXbRrTduKmnfhds+JEvF+ecRMyAu/rc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <200E6F821EDC04448C31A29F8A02D6AE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AQzrHtNkeepSKP7bFIE93KyLXZ2yzuksW3s5iVj55+R9x29l68xZQ0FoWMZOaC0JBSOzH26AnOdBQEPLnMsLRqDY+1Ga/xL55LJD6S1/mvZmk8QqH4hR7HBsQnGL8jPCC4uVdRrglKy8VdhTlihJXCtwMXl62x1kSBEg+zJ2GdTKg1eXS9zLicpe68i/Cmv6mqhGwj+7s+txELhVUzOnvzFctq7r0Z0Qshhcyf6DEwXlqww9IdmErDJN5cLY/qlqufWpv1iNjzSCCAH0sTzTWFLvG8V4jq4Yr6n90ufh87MJ+lJT3wxmE0eXNfqRv8mZxEHm4ECgwxz9zb6lUwvSbQstW1p12vKQO3mRQ9zqE4/Yw+8DXKBgefIck24FNI2xwU7irA0pLNy4dZJ6IjlHAE1487jCJSmKCjCYU+vrPW8MLsBmUKa6VCi4iUns8AWQk6sQJkzXAM5DX2rZuYu3znNb2GZwIxfWzyhsgalOQGIglzulYGbxrbi0bQh9NiVDsv0hm0pF81KtWBZOXMz79KUVWMCnlqMsYY3E2Ite4KPWk0kVMHDbgpwCNf+dmnT8350FJUp3gwUORm7nsyW0ND/cz57CvG/uIoLrM+VJ+I5375PTxLdG82A1Zd1DOLbU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce766ae-f04d-4d6f-77e5-08de75024cee
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 06:43:07.4118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eQ7tT8GSd/1CzwZfp+BdrrNGGXONEmdpfj4mebA0FXYT1pDQVFeLKAZ2KbD19QcXGPkAteFnhMwKT+ECHvrSOatP/YiYJxN1YNpOVq8oChk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8065
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.94 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[wdc.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21947-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	R_DKIM_REJECT(0.00)[wdc.com:s=dkim.wdc.com];
	DKIM_TRACE(0.00)[wdc.com:-,sharedspace.onmicrosoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	DKIM_MIXED(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sharedspace.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 3AC111A1640
X-Rspamd-Action: no action

T24gMi8yNi8yNiAxOjIxIEFNLCBRdSBXZW5ydW8gd3JvdGU6DQo+IEluc2lkZSBidHJmc19mcmVl
X2NvbXByX2ZvbGlvKCkgd2UgaGF2ZSBhbiBBU1NFUlQoKSB0byBtYWtlIHN1cmUgd2hlbiB3ZQ0K
PiBmcmVlIHRoZSBmb2xpbyBpdCBzaG91bGQgb25seSBoYXZlIG9uZSByZWZlcmVuY2UgKGJ5IGJ0
cmZzKS4NCj4NCj4gSG93ZXZlciB0aGVyZSBpcyBuZXZlciBhbnkgZ3VhcmFudGVlIHRoYXQgYnRy
ZnMgaXMgdGhlIG9ubHkgaG9sZGVyIG9mDQo+IHRoZSBmb2xpby4gTWVtb3J5IG1hbmFnZW1lbnQg
bWF5IGhhdmUgYWNxdWlyZWQgdGhhdCBmb2xpbyBmb3Igd2hhdGV2ZXINCj4gcmVhc29ucy4NCj4N
Cj4gSSBkbyBub3QgdGhpbmsgd2Ugc2hvdWxkIHBva2UgaW50byB0aGUgdmVyeSBsb3ctbGV2ZWwg
aW1wbGVtZW50YXRpb24NCj4gb2YgbWVtb3J5IG1hbmFnZW1lbnQgY29kZSwgYW5kIEkgZGlkbid0
IGZpbmQgYW55IGZzIGNvZGUgcmVhbGx5IHVzaW5nDQo+IGZvbGlvX3JlZl9jb3VudCgpIG90aGVy
IHRoYW4gZHVyaW5nIGRlYnVnZ2luZyBvdXRwdXQuDQo+DQo+IEp1c3QgcmVtb3ZlIHRoZSBBU1NF
UlQoKSB0byBhdm9pZCBmYWxzZSB0cmlnZ2VyaW5nLg0KPg0KSnVzdCBjdXJpb3VzLCBkaWQgdGhp
cyB0cmlnZ2VyIGFueSBidWcgb3IgZGlkIHlvdSBmaW5kIGl0IGJ5IGNvaW5jaWRlbmNlPw0KDQoN
CkFueXdheXMsDQoNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0KDQo=

