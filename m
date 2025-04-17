Return-Path: <linux-btrfs+bounces-13142-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3261A91F3A
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 16:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B199C462ECE
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 14:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12AE2512C7;
	Thu, 17 Apr 2025 14:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="J8MGNIZR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013038.outbound.protection.outlook.com [40.107.44.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285FFF9EC;
	Thu, 17 Apr 2025 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744899326; cv=fail; b=l+/AIp6gCUY+L/dhb4s2BzcgSRX8eZiXjmPEfP8idsZ1NZ+2m6xMizDfVtWamggW+1XUH9rQvg5Hov5vHR13WCKeGdJF1hSA2KTlNnRHtX6PsmVvjEmo8MKhEEsh5jLYbCVNZlnZGhAcyz8HQsww8RmTbjP9WQdJc3XlxD3kEqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744899326; c=relaxed/simple;
	bh=FBQ0hQMr39VN2X7SnpYtbekfLNot3MfQL4kl5x1jVPI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tK/62Y4nUXHQsuxuoz8oALzjmW66BsiXZJfnUTOouh+y8WyW+ZC68K7LWRDbCUosL247rIs1Exvto5V8SU+K/+KZfwb3WfZmmNs1Mmu9W8lKnVaTfaTMFMEsIPatZOlrsIt/Fq6zHPp6wjtOFRZ6DiRH2UmjzQMiyCg6Sk5fAPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=J8MGNIZR; arc=fail smtp.client-ip=40.107.44.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHI2qmCwhtihcKEo//uP2w/6enN7prhkIrwuNGhHqsboTDFnFosVOg8cx8qbDcgQNMeeQPGtw8qA5Y9ReaUSajBQ/kZxmGt9iTVnbp5c1Xm/A+uOp0ZDr5bpMsXNPZF4i2Uuw6F4MCt/pJDCGYkVsVliVfYbw2f/DaHZpEaK1PyVVVI61U4iaKQzG0k/nBULy6+uuj/kSLOC2EQVasaDp7y0YVyokKIlEC/WQxB5pDLD/jbZO95WffBfalnC0J6zGQgy19KkpkfIFkJkCt/IsgNo4g/6N2JYGFW1ngpi1Aa1p69me0U6WcnssWMdTzpGXba5NyL61OiGgRjzOd2lCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBQ0hQMr39VN2X7SnpYtbekfLNot3MfQL4kl5x1jVPI=;
 b=LOVUqvjVgeB+NSAe33z3Duebp2BIJk4iwpNQfztGZ1udZE/SrnKhQLCwBFuREc/aVXg+sUyou4Spz8Cg/hhL1Qbpp7FQSW2djnJNdAQqEt3SZJjYoOE44X/DjqKPesmCwJFpzykiC3HUEhpyxfUwkgSA0chUYpID4r3es3ABHt3yLXXm3GZj9+dnROBO+pQvLd5vAc8+y7sZtxnVZUzNsA0DveHZuTgqI4148ISCIxZ3qZiCiA8UWpOOC5lDxUsQ122+oPOWEptBAL8jshZcwET5h/cqF7+OPwetkrpUIQ6cuLbXNpcIyN2GO0k7QJt+RU9fRhyTWWyTgQap9ER8pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBQ0hQMr39VN2X7SnpYtbekfLNot3MfQL4kl5x1jVPI=;
 b=J8MGNIZRwLzfbEotu2dub1I/xw4ptBbXnwm2xFWU8hG205GCk77FCU5p/17cWwHHXlpxLHk6oP6jeHRRXHFhUlAyUfMV/mfjRWC2k+AURUlX0xW9OoH0bxOywvhr/FPiEN6z+SOZlVb/Kc5n6SXLcIEYdoSTS4h4zRCyqRthIaB73jdRHEGHt2bmDWMHY7bvnlP7Zq+6x5aYTRoHPpnAjG6Zo+ON/JiEvQCqlPmcDWINF3jPRnYYpEntW5DFQXdVEoozT6MTkK6Bifn7RGHYyqxbv71Mp3oOTPi7hgIBtTgnDp1+5cvjMTacz5ZqvXg1rYxUolxbgZrcQFQEtKye/w==
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB7025.apcprd06.prod.outlook.com (2603:1096:101:1d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 14:15:18 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 14:15:17 +0000
From: =?utf-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
To: Filipe Manana <fdmanana@kernel.org>, "dsterba@suse.cz" <dsterba@suse.cz>
CC: Sun YangKai <sunk67188@gmail.com>, "clm@fb.com" <clm@fb.com>,
	"dsterba@suse.com" <dsterba@suse.com>, "josef@toxicpanda.com"
	<josef@toxicpanda.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "neelx@suse.com" <neelx@suse.com>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggMS8zXSBidHJmczogZ2V0IHJpZCBvZiBwYXRoIGFs?=
 =?utf-8?B?bG9jYXRpb24gaW4gYnRyZnNfZGVsX2lub2RlX2V4dHJlZigp?=
Thread-Topic: [PATCH 1/3] btrfs: get rid of path allocation in
 btrfs_del_inode_extref()
Thread-Index:
 AQHbrbUqBDIkC3HhxESrhQE2MboFAbOkzooAgAAT+4CAAWa94IAABL2AgABdN4CAAAhOAIABNs6A
Date: Thu, 17 Apr 2025 14:15:17 +0000
Message-ID:
 <SEZPR06MB5269D8348566FC049107053FE8BC2@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20250415033854.848776-1-frank.li@vivo.com>
 <3353953.aeNJFYEL58@saltykitkat> <20250415155637.GG16750@suse.cz>
 <SEZPR06MB5269DCFA737F179B0F552B01E8BD2@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <CAL3q7H7z_iVmeuRNXQvvZseB9ntSDz9_tUTXB0KvrcsSQVJb9w@mail.gmail.com>
 <20250416191111.GC13877@suse.cz>
 <CAL3q7H4_vNoKokn213rY2Q0MNkDLWSk7XRBqJLxfiw1ikRGM7Q@mail.gmail.com>
In-Reply-To:
 <CAL3q7H4_vNoKokn213rY2Q0MNkDLWSk7XRBqJLxfiw1ikRGM7Q@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB5269:EE_|SEYPR06MB7025:EE_
x-ms-office365-filtering-correlation-id: b05ad318-68b7-4103-b7e0-08dd7dba47ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dUEzQ0xIOGtnY0RiMmQ4ZTk4L1hDZTlDUzJiTVhqZGs3Y1hlTVJpMzlsNFJu?=
 =?utf-8?B?UnlKTXV2Y29KeWc3a3loVGwzZXovL0RHUU56RmFoM1RXQXhPNVRsTC8xcnJI?=
 =?utf-8?B?NzUvZXlHVkdkMTFMMllDWllXSnlkNzFpQy9xRXBrQWJ5Y3ZnQ0lrZjRHdERi?=
 =?utf-8?B?RkFqSXE2b3JmRGFFRDN0Z0s0d1JXWlhZR2hOM2lCZ2lMcU1PUzhZWTJnbGZ0?=
 =?utf-8?B?TWxSYnRLcDVBT2ZPczZKZnBUcjdWZnBnemQ3aGZnQ0RqWThKaVVnOTVkZ1dS?=
 =?utf-8?B?ZVBlNFg3VWVVUTBoR3BQNlkrZGY1Tm9CaHpob28vTjQ2eEFGTjIrWFVKbG1u?=
 =?utf-8?B?Y2xFTmtmbS9ja3JFK3pFa0RUTzhDbXpnczk0M1BVL2E0bkRkZmVwNVNpWE9t?=
 =?utf-8?B?bXpFSHRLeXNJUGZKclFKdWM1VGtmS0hSR2xhbVhPSXFLS09IcEJuditxRUNW?=
 =?utf-8?B?L2tUR3BwZndUNkxVeUZVZjFLNm1uV3c3SDdFS21QdkwxeVpLZi8yMTkzWHI0?=
 =?utf-8?B?cGlNdzlFQ2F4MmtPT3YrMXhYbjE1Y0VNdHZRQTBtUk15dnhRc0RaZXNGQXZx?=
 =?utf-8?B?SEI5NE9LZ0l6MkQ0OC9CdU1GTkFrbEs1aHZpeHJZOVl3MEdwTTU1RmdWTGVJ?=
 =?utf-8?B?QkFOYmN1TVFOZm5CRVZHekJMU2FZRCt3UzZEeDlKV2JNOFNOSnJqUC9oYnFZ?=
 =?utf-8?B?UXo2MUh0b05MaUhMTEptYU5IVTBKekdaRHVXU0gxOG1QaE9CcU0ycW1Bd2ox?=
 =?utf-8?B?bFA4M3ZoVzJ5VEtoNzR0ZkRSNi9QTlFha0Y5S1owZEhhWXM0SlFiRE8rbU9i?=
 =?utf-8?B?VGFmckNXMkEvSzQ4eG5jemRYNTdJWldHYnlGT1hrMUd4OTlkazJwejdFUGNz?=
 =?utf-8?B?TEVMRXZRaC9pUTlYZldCcnhYZGYvVE5oeUlJNHBYaXloRDIzakRXQlBVWHdv?=
 =?utf-8?B?cXBHb1dsaVdIbDdpL0lLRnhEWVFZMGMxYmhEVHM0K3IwNzAraHJXcmJqN3px?=
 =?utf-8?B?b29mNjlFeU9UcTExcCtIRk85d2Q1c3AzKzVHYytMaStGaC8xUERObUFHaXQ2?=
 =?utf-8?B?cmU3VDVkdE83MGVDblBidmFlTW9uZ0IxSGs0eTdwUFF2NEdRTU5FSnlQclN3?=
 =?utf-8?B?OGI5U0FXNHBmQ2xteXA1ZmJIbkgyVENkMlpUWGtZZ0RDZGg5MXI1TFdBc016?=
 =?utf-8?B?N0xLRFFXNHpqeXk1UVB2VVptUFhCSFkrenpSSGwrbmw1UEtLbjArN3VaclZw?=
 =?utf-8?B?bjRtZ1lBWlNZNnhCS29jdFpyVkVNTlU0NXV1VnRPbkhrbVgrVjEvTVpqRmlo?=
 =?utf-8?B?cWozcXlaUjdSL2p3eGlOak1XZFhzeituc0VwRzdPZWlkdmZXaFBWeklQdGhP?=
 =?utf-8?B?bmxocEpaTTNhRUdoVFRtM0Q0TkRsODR4dCt0WS84U1N2OG9VK0Uxak9Oc0x6?=
 =?utf-8?B?b1V3Szd1am5BeE0yRkhBaURSVWhUWlp3aHdpUWdHQkdSZXRRQ0tUYnVUR2lR?=
 =?utf-8?B?ZDdNUDdSL25aOGNZS3ZCRkxWbWphWWsyelQwMGVyaFVHdHErQTl5T01LbERv?=
 =?utf-8?B?M25qYjBSaDBONHp4WjFjbmhybTN6bVpkNllRS3JoYTBma1BQZTl3RUJYa1Bu?=
 =?utf-8?B?Q0hHVkdnSGZlMUZieFMwVGZhSC9Qa3pOblhONHhHZ2U2Z000SUU2QnB3eC80?=
 =?utf-8?B?ZVJMbDA1U1RNSUdRTlMyc3UxS25TcEgvVWJiRVlURUlsVmFWYVRtMHhMQWJJ?=
 =?utf-8?B?TSsxenlyclAyTjFWQk91WlR4cEhNN2dmQnRLR1FYN25leUF6bWx0RkN6V2RI?=
 =?utf-8?B?SUVTSUtZS0l0VG0vVVZnWmhjTHd0eGhncjJ3L1prbFkrUm81UW95Y3lGbFIy?=
 =?utf-8?B?bkQrWWcrQk1YalVHVVU1Z2dXL3c1RFRLeno5RUJId1dINE9uTExDR3VSeE5s?=
 =?utf-8?B?a2ErbTRmbVVqc2JNZVEvdVpzdCtXY1JPUXR3T2RXOCtLckh5VXU1NVkxNUxt?=
 =?utf-8?B?V2lJOXJXc293PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZExPem55VjBIcTYrMitFMDZOMktqSzNvdXN1UTFlU3dvTzlXVjFqanJoZXo2?=
 =?utf-8?B?cHM5RnNyeUR0NVBEckFzQlV0RFJCc3V2eGpxeWNYaWhIWDRxVkF3Sk1vajgx?=
 =?utf-8?B?ZHlqeUtJRjNxdjZZdmoxWGlDcjZSb0RqTnB5T29kU1F1ZGtKY2swcE1ST3No?=
 =?utf-8?B?dFNGT2VJSE9ZeFhsc0wwMmNJVzFHclJaZlN6dk02QkhtODZSQ0dwMkIvVlZn?=
 =?utf-8?B?a0QrR0gydFlQRkNBcmVLdFUwazlJT2VhempscStjUmZBMitQbnE2QTBqaFdH?=
 =?utf-8?B?OUp4d2dKNTdSTmVjb3FKdUxGdVJ1TkE4Sm02aUFXNnFBamIyWHRlSDA2V2Zq?=
 =?utf-8?B?RCszM3pWcXhFZ1o3UVVnSzFERXBIcHVTU2Q0VG5tMVNrZloxT3V4Y3kxekxD?=
 =?utf-8?B?Q0lCRUg5bjd2ODhOd2RZUmxZejVXOE1QUERjZmVMOUFzamhwVnYrNWlOVXJ5?=
 =?utf-8?B?bEEyR0RXaDc1ZDNsR3YyMTZXSkxCUjgwVkRsYU05US9URVNZaXlubURqU25m?=
 =?utf-8?B?NVJhVE5CTFE0ektJVjhybi96TTRSQUV1YmQvN0RXcVhhTnFDOTJQT2pjS0RO?=
 =?utf-8?B?WnJxUno3dzJDSVVOcUVhMGFUdzRTYm1TdGZyQWFLVDhOV09WUzMyRTZFVDJu?=
 =?utf-8?B?UHY5WVhUN1J2R2VaYmVzWmgwaVNMeGJyUDI3Y1B4Uk5BMEtpNUlmWFBYZURP?=
 =?utf-8?B?dWpGV1FqSGgxV0NwSjRBdDRWSFRwWVozWGxtakNSTEV3UklHWldPT3k2dlZH?=
 =?utf-8?B?OFA5by9qUWJFTHhPT3BwQjhJR0dzMURDeE5rSmNoaHY4UFZuRWlkOUczWlVx?=
 =?utf-8?B?cGlCQ2pHOFBKOFN2VVNmUXJmRVN4YXpDcHhTR3dnejNuVVhkMmtYL2h4WVlt?=
 =?utf-8?B?cEE4QWxiV29IbzR3eEZUNjZVVHhWbGFQaURSZ1hGS3VyV0VzdkFFVE5RNTRT?=
 =?utf-8?B?Wm1HNXRENURXMUxqNENHVHlReGY4a1NscWZPTEpkVW1DOFdVVWpsSGdJNlhI?=
 =?utf-8?B?OThHK0MwNDVjTWRSSEgvVEY1QmUvVmNWalVVZFZQNldxbGk2b05ad3dsSTNs?=
 =?utf-8?B?UmpBOHhnU3N2dWU2a092dFllVUhTcjZYNnJaZ1BxU3p2ZXd4czhPMTBkM3Ix?=
 =?utf-8?B?MWs4S3krVEJCN0xZb0V6eWxmd1JoeC9IT0Ric0MrdzlSQUpnaTZZeXE4KzhD?=
 =?utf-8?B?c0ZHSlRKT09lMmdEa1owTWsycWV2ZDNkVW1TU2RhUjlNVFB4ZEx1RU9ROUVw?=
 =?utf-8?B?TTQ2aTgycnRLNEJNV3JiL0dLYXVGT2QxQURSV2d6cWh0L0NyK253cS9lZGsx?=
 =?utf-8?B?NzVGUEJHdzhLRW5xZnBtZjQ4WHdpQlJYY2gwd1hDcFpiaFMwK3ZsakJoYWZT?=
 =?utf-8?B?M2Y0bCtTbCtmMG4yKzhxdVE1RUZmdG03NEZnUkFIYXY4MjhBNllsOFBWUG9F?=
 =?utf-8?B?RWlZdTdCL3hoaWJwaVpYcjdlVERBWmhKZHVqUS9FZFp5RGJFZnNPZ3pPTkxN?=
 =?utf-8?B?VTdRMjNVdXJmTzd5Vm1LSzlkZlRiOXpydnc4b0ZnK2JHdG41VEFJRG1MV29v?=
 =?utf-8?B?NEF2d0NmUDcxSHpBVWgvMTlMMzZCdDh3OXU3dVRnT1dzOHBwKzRsRmJxbmM0?=
 =?utf-8?B?dmhJdnNvMVRjb2lXdVlhQXY4WEE2YzZDV3Yyd3lNWWJiWllXNTFVSWVXMzIz?=
 =?utf-8?B?cTlSRjFBenV4UHcyRWdER0tOOXJOcUgrZExVWGpoZFVFWTZPL3NmS0R6ZWZo?=
 =?utf-8?B?VDg0eVRLK3pDMUxZWXA0SFBtU0pHWWRDUnZObFFUV2lBWWY5Qk5LNmptZmZO?=
 =?utf-8?B?a0ZvekxKbm1VbEtmSVNUOW1FQmVkYVQ5SFM3Q3JyUjJvZUVyZGExdCs3NS9K?=
 =?utf-8?B?dkJ6L1J3UmpYV2dpR0s2N0tmQVRoMFU0c2hTSm5nU1kvL0V5SFdNeXAxNWd4?=
 =?utf-8?B?c2lGK0o5b3dvOGkzanF1Q0xHZE0zSEErc0VaTEI0M3dXWG82dGpQSnBTQVp5?=
 =?utf-8?B?NkFtOG9YcDhnNkNWL1dQd29vWThHVlVVU1NSTlZhV1hGcGdTd09HelhPOFY1?=
 =?utf-8?B?b05aN3FJT1dmeWluWENmZUtsdGJsdkRQd1hYek1MMVN1QkZDTXpVRjcxK0Ny?=
 =?utf-8?Q?rvLM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b05ad318-68b7-4103-b7e0-08dd7dba47ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 14:15:17.7191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4JFu5QZAgQxgmUstUmgYlTuqbthsLs4kbJqhtY9oDMOSz7x02lY+qaat7mBOYt34j39O+Uxj4XV8S2xVDxclXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB7025

PiBIb25lc3RseSBJIGRvbid0IGxpa2UgYWRkaW5nIHlldCBhbm90aGVyIGZ1bmN0aW9uIHRvIGRv
IHN1Y2ggInJlc2V0IiB0aGluZy4NCj4NCj4gTGVhdmluZyBwYXRoLT5za2lwX3JlbGVhc2Vfb25f
ZXJyb3IgaXMgcGVyZmVjdGx5IGZpbmUgaW4gdGhpcyBzY2VuYXJpby4NCj4gSWYgdGhhdCBib3Ro
ZXJzIGFueW9uZSBzbyBtdWNoLCBqdXN0IHNldCBwYXRoLT5za2lwX3JlbGVhc2Vfb25fZXJyb3Ig
dG8gMCBhZnRlciBjYWxsaW5nIGJ0cmZzX3JlbGVhc2VfcGF0aCgpIGFuZCBiZWZvcmUgcGFzc2lu
ZyB0aGUgcGF0aCB0byBidHJmc19pbnNlcnRfaW5vZGVfZXh0cmVmKCkuDQo+DQo+IFRoaXMgaXMg
dGhlIHNvcnQgb2Ygb3B0aW1pemF0aW9uIHRoYXQgaXMgbm90IHdvcnRoIHNwZW5kaW5nIHRoaXMg
bXVjaCB0aW1lIGFuZCBhZGRpbmcgbmV3IEFQSXMgLSBmcmVlaW5nIGFuZCBhbGxvY2F0aW5nIGEg
cGF0aCBzaG9ydGx5IGFmdGVyIGlzIGFsbW9zdCBhbHdheXMgZmFzdCBhcyB3ZSdyZSB1c2luZyBh
IHNsYWIsIHBsdXMgdGhpcyBpcyBhIHJhcmVseSBoaXQgdXNlIGNhc2UgLSBoYXZpbmcgdG8gdXNl
IGV4dHJlZnMsIG1lYW5pbmcgd2UgaGF2ZSBhIHZlcnkgbGFyZ2UgbnVtYmVyIG9mIGlub2RlIHJl
ZnMuDQoNCkkgYW0gZmluZSB0byBhZGQgYnRyZnNfcmVzZXRfcGF0aCBvciBqdXN0IGNsZWFyIHBh
dGgtPnNraXBfcmVsZWFzZV9vbl9lcnJvci4NCg0KRGF2aWQsIHdoYXQgZG8geW91IHRoaW5rPw0K
DQpUaHgsDQpZYW5ndGFvDQo=

