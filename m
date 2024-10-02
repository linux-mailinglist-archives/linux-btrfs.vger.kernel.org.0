Return-Path: <linux-btrfs+bounces-8436-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BE798DE01
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 16:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3EE21C23E98
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 14:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8891D0E2A;
	Wed,  2 Oct 2024 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d4Kn7DHO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SmU1L3K1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1020B9475
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880732; cv=fail; b=aZ7Hzus3oXd4UBnp3METwmxhFQu8iJLUQVHclLfN3zNkV9fMMN5oo9jYSqnZNlewfomTXU4jfbNm1BIgYw+yNhFtefeXkTEuXMIdZhmWsKucU+NXwARRtVL7UGIDeelNnN9FKL+wuZiT2X3asjhBNSwHaPgVFxFJsvrwzyfJ0eI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880732; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qf1C/IpMXQMUYneXNDFhBe7KLZoJ6isf9wKY3aFRwoXzQ5LrdVTAPPb9S0AyHuENl8exAl7XBgET2plVkcswWVaq9ahF4580pygyW6Gag7c48pyWaWV5WvSvXxpCoU8xCsEQTG7vdgMp9bp/AGhjjMvQw8n1xj6cK4Lck3mdW5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=d4Kn7DHO; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=SmU1L3K1; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1727880731; x=1759416731;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=d4Kn7DHOaIeIl12pXuL1BTxZu6flS4uT9R9xe1ZMloGffKsBXx7EefyQ
   RuOt8UmflK7N/v/qYP3/NOaDYrzu5/i32Es1mipcMc1CnavVbgQVA/74b
   eDQqgi7hEP9TPaUZfejIzKTjq4YtXK2IIugHuU4o7ZU8pCPgAWFg+XcyP
   HjPNePtw+rhuPu5nwC3ykZVE/cBn2EhdvxrM1eeCOXQGaOEtOWPZJf4MA
   ltxb/sJPfDjoYtR1qNmV5NZqOY9HNP9hKC2EBiHl5FC3mQPRv0E5tK+Jm
   M4ZHq/CJuJGvO+nRW95by5RJGKuf94M+imEeD5lpw7y2iqxU+dQ8zI0mD
   Q==;
X-CSE-ConnectionGUID: ERIrmvDsRXKiucKnpBOSow==
X-CSE-MsgGUID: EPbc9PeGRX2jvGLXxiZMcw==
X-IronPort-AV: E=Sophos;i="6.11,171,1725292800"; 
   d="scan'208";a="29164928"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2024 22:52:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbuWFklJfPYkQfIY7HeZ/leiixJeh/ZEIhYjhJo3k2G4VqBhqkBPSyTFdQKMqJ7xGmPntSOl7K0+uVcXIlxqTJCcFsudw4F7FyXOPg3qXRAFgxgqoBM5Wb/wePgs0wqrTpQ3dIK1t709gu0rVBGq1rhwgEovXLHiGGx6R+rggiN2T26FQcAe4gP+jeqSZNV6sPVoMkL29b9w+YUbONee4mghnTtNnNyOO/hT7PTtCRMPAqge0Gi6Os09KvFJbP0HiWdC8T4e5IE6XV8nPCEQvyypQA7jxsWxbbIAhyJICV0J699PwTWLhLcF3Rz3NE6H7kg5Aoay1maO1NXzdyy4dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=vVzMf6rWUq7TCXSqZ3BortCb8UqZWd2o9DCXVw17Dj7BAke8bRg6DLZF25UaBX4/NbyROfQ8R6sywgvvyG0auWG4VF4YEKqqNwIIy16c76VKjqovdbak5pBebEJab589VJ9jUtpHH/YKq495AahTAL6HYNSAuTersOV9WHOLeYuVpRY6wljTtT4Z15cjdfPzfBMrZJxHRH0pNTG4M/RIOWMpiCrc/FK2OhD0GvMnC0L4wOKnxQLrezm7Ke66tOOpcg7yotyNcWvHRedZ8n9dco89VzcCdC8/ElVzCAlb7xcuf66LmWGMIwIYCfJuxrlCHiVzZ5VieV8A7zAMe4pW9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=SmU1L3K15m6rRI2BzOBV1CzTJfEDw0bpSgltIcEPwE3osJiW6E/1NlWUMwbbB1Xd5NanMPC1zQRDEZcyO7H2J2Av1zAa6/NmWIozbLnGkpYfCCfniVAFd+Qj/aTjq69bsJQQR5XjMcTgB3z0zJDOyyKkMA3aTE4fTXczQroB+0k=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB7018.namprd04.prod.outlook.com (2603:10b6:5:24d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Wed, 2 Oct
 2024 14:52:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 14:52:05 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: fix missing rcu locking in error message
 when loading zone info
Thread-Topic: [PATCH] btrfs: zoned: fix missing rcu locking in error message
 when loading zone info
Thread-Index: AQHbFNZG5qC2BooT8kKmERDE8UEX0rJzi56A
Date: Wed, 2 Oct 2024 14:52:05 +0000
Message-ID: <06054b86-089a-4280-82ac-9e479aaf16f4@wdc.com>
References:
 <446a65bde464d5a19554687ffd1944bfbf9062ae.1727878321.git.fdmanana@suse.com>
In-Reply-To:
 <446a65bde464d5a19554687ffd1944bfbf9062ae.1727878321.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB7018:EE_
x-ms-office365-filtering-correlation-id: 6ed7a640-51ab-4fb5-c9d6-08dce2f1c855
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eVZIdkpTZmZ3dU42dHpOcUVMM0wzalNrK3hWN0xxY3cxRjRxbXhCTmh5M1dz?=
 =?utf-8?B?cGs3MzIxZ1o5YS90Z21JajhVUGpYVUF3L3FHaThBWXdLcE92L1poYkpRQ0ox?=
 =?utf-8?B?ZEEvblBkRDVTY2dwd3ZCL2IwNmpucndqdUkvdkZWby83eVd6cUYvS3RUOFdB?=
 =?utf-8?B?dVlBVEZNQ1hndHc4RUE0aThBa3E1K0syK2Y4ZG5BUElvS3BHRnFJVjhjYk5X?=
 =?utf-8?B?M2ttZFN1YWRyaGEwVk9sTTNOMldVQzgrdGpsaDF3MkxxMUFBR09vaXFwS0cw?=
 =?utf-8?B?QThPbW0zTDZyMWRWS3BVUGpMMmVMbU1TMVhzMFdQZmw1L0dWWWhna1dMY21H?=
 =?utf-8?B?UnlMdDRxc3RDMHdKWCthdjExMS9seVBzWURhNzAzMXdjRlUwaS93WEViODFj?=
 =?utf-8?B?RlV3V0dWSUd2azhsbCtQb09wSjVodmQ3LzNidzgrc2Fkemt0RFY4dnM2eGpS?=
 =?utf-8?B?UWhRNlNjR2lPM1ZYUFlvNnJuV3ZZQUpLSDZNaTJEMkhubm1oQWtHWXF0MjYy?=
 =?utf-8?B?Q2J4Yjk0Z29lYXpwVEZZZWV3KzNiKzF3WVNUbTJ6M3oyME10TGx2YUd0SjNL?=
 =?utf-8?B?MThOKzVjaXp3dVBTcU9nLy9aYjZ5OTB6cVQvT2RUVlpoZWN1aTBjSndxV3VC?=
 =?utf-8?B?ZHhFQTFSckU4M2pXMEo0RDhwWmRZOUdPWmp3L28xQVBKMGFETXMrYXhWaFE3?=
 =?utf-8?B?OEVEakVGMkl1UUNIODRzaURTVEtUR2ZXZnZqR3ZWdjMrNm52V05oVXQ1aldy?=
 =?utf-8?B?TG1OcHJvRFpFZjUwdmIwQkx3a2pJcUt4clFLdW1EQ1FnOTNWZ1BhOFRtelZC?=
 =?utf-8?B?bnozZkZKanU2NUlBaURDUThJTXRPN2FHR2ZDNllBam84M0h6a09rYUJCUWhy?=
 =?utf-8?B?R3EzR0dIWWk3UnVVN2Z2TFJqb1Y2cGw3QS92OVFyaHphdjlxcjRoUmx5MExQ?=
 =?utf-8?B?STY4UnJKL0VlQk1vR3NSRXVyM0tDdTd1b3hUelpaclpkNUNERTJ4S3hTR2tX?=
 =?utf-8?B?clh0ZVM4SHNpYjZmcmkzRExnaHFKR1BMc1daZk51TXd6V2puN1ZvdlRRNGc0?=
 =?utf-8?B?RklRaG56T0EvdmpPVUZiM2F5NkpycVZ2d0FpVnVnR2cveFE5OXREMzRPakhj?=
 =?utf-8?B?ZklTVHAwRzBkZHVhTDN0ZkRwRVMxdEFocnN1cEV0eDFMS1E1bFAzY3RrUnEz?=
 =?utf-8?B?cFJRVHY1MDdobE9XbmhMSHAwRUp0YXhzdHhjNXdEM3JHRFV4U0xHSEdta0JJ?=
 =?utf-8?B?SU0zRTJQWVZYMEZBU2RtcVVlbWxWVlRYVmovaWV5V1ZoSi81QnpBRWNQbVRM?=
 =?utf-8?B?L2JLUjQ3aHAvaVlKQWt2cGN4NEFaZWNaNjA4MGpXa3YzUTAvSFBOTzIzNzBJ?=
 =?utf-8?B?eVBIVjBLd1U5OHJ4WlNnc09PcFFQSTllT1daaGVOZDFaNjFDRHRFMVRmOXlN?=
 =?utf-8?B?TUlsbWx3SWYxaFN1ajdpMXMxZjFRb095RjNwVnpUZzNmdjcya3FEcjlYa1V4?=
 =?utf-8?B?WGNzY2xyanNOdlhGTVNTdVJEYTdLaFVHU0R4RVJhcDJUSjJTY2dnSUl6K25P?=
 =?utf-8?B?L2tya1VWaThBeHIydG5HdUVJV0lTNTQyaTgrQnhSb3VsNWQ4MEhRT1JTLzBv?=
 =?utf-8?B?dVRneXBxdmcxNWVGRFVoanN0aFdVdWZwZXlxWGsvRXJrcW5JN2VmQVEyamNQ?=
 =?utf-8?B?cWx5R2xGbDJiczZUU3p0bHE0SVErNEl6Nmp5T2I5c2x4UmxHZXFRSVpMVWRo?=
 =?utf-8?B?TVlsa0dJcWRtQmZLNmlTdEdCNEx2dVE5aWM0eGpLVHRNenlsUVI3UDEzWUI4?=
 =?utf-8?B?blExRE1Lb0lKUGFpUnhKQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b2oxTTJwc2IwTlE5aEhvemFzdFFLdUVuZ2NQdzlaSEFPS0w2T21RMC9HVDln?=
 =?utf-8?B?Sk16Mlh5dzRzSWhlem96cU0ycFRWQVlucGxrNFZLL3VzRTkxMXRKWW9NMWlV?=
 =?utf-8?B?Vi8xODN1WG8vbmlXa01Xc0E0SkhrWVJnSzJtVi93YkJid2tpK1BXVkw5Z2Mw?=
 =?utf-8?B?OVlmWG1ta2o3aFYwYzhSNVp2OExCRHRLcFR5RnBpMTNDSjRWV28xaG4yek9w?=
 =?utf-8?B?ckMrNGpGZVl5SjNPb2xqcC9uc1ovZjZvSWUweDlvMUppMEQ5UnJmN3dLeVNR?=
 =?utf-8?B?aDJnaHpRWFB4Uk80QmM5SUtNY1JNRTNkNXdZdXAvdHBvU3JUYjhUdVQ2WXNJ?=
 =?utf-8?B?THBWT2l0S0dWeVk0OU1jWUMxek5rUEdCcER4aWNubXdvM0hEOVZvVzRBRUxZ?=
 =?utf-8?B?WVZxVkFBZUdWUDB2YVFVVWs0VU5YMUFDMCtFREdQdE1VSGJob2R6SHhJdExX?=
 =?utf-8?B?Vk9URGdxb3FlKzdDajROcWZLR1pZV01Kajc3MGF1SDBSeC9vQVFrcTV6dUFY?=
 =?utf-8?B?TFV2RldtQmk5ZGhBbTNNbGdPWC9KdUgwb0szcmljUTF4MkFyRGhha1RHaUs4?=
 =?utf-8?B?RHBGblVaZkIyNm1zYnBxc3NDNnk5VDRhdDZsZVNuc1lNTjJ6UktydXkxUHg5?=
 =?utf-8?B?K0IzR013VjFTb2pBSDZ1eWZlWGprSmt0d0pxcVkwTDBGNmRzcmdFeElrMnBk?=
 =?utf-8?B?NWQ0UHM1OUtDUnFrcm1tWFN4Y0prOHNhRzVnZ0t2eFpmejBYaHhaZEdiRlRO?=
 =?utf-8?B?b1JiTGdTazQ1UzQ0OStTSU5vR2g2akRGaVpSaHZxQkplZitUUllKUHpjV2tl?=
 =?utf-8?B?N1ZIR05wa09FNVg5eWNhSi91Y2szT05CajBpZWFFQkk1aFBKNUpYRnBKM0t6?=
 =?utf-8?B?bnNWbi9YUHFReUVkSkVLMk5UNlgvTHhhbklHYmlaZCtUWW13bmUwL0g5K0xq?=
 =?utf-8?B?cWo3MmV5M095aDBFMnZnZi9NYjZDL205REVla0Fydk9HR2pKTWoweTJOTXJi?=
 =?utf-8?B?Q210WWQwUi9yNys5RTllYzJ1ejZLZ1l2WkhmNGNxVmJ6NjRLL3RmVFVUb0I2?=
 =?utf-8?B?dFFDQkcxa2tSNGl2ZmkzNCsybmI0TmpaQUpvRVRYckJrdVdjckVzSEtVSlFG?=
 =?utf-8?B?TC9EQ1JoZHRhbVVja3VyVzFUWG9OWlpKTzFnT3JVRmFJRSsrd0FqUXJSMnFl?=
 =?utf-8?B?b20veml2VGpBMzZhTDR4Yk5EZGYyMHY5SUk1cXBIaHF0K29yZlpPbCtzN1Y3?=
 =?utf-8?B?M2JvWVQvTXQ0aE5RNHR1WHJsNHNKcGJadk9JSkpaNDY0T0Rla1RuaUxNc0xm?=
 =?utf-8?B?VXpEVlRyUTNNS0ZwZHg2c3dLbjZGWTQyaithNkVrU01VMXl2OFhMZkhRbUlZ?=
 =?utf-8?B?ZGVVUkZyelhkU3k4ZFEycEhoSU9TZ3V6ZHBubjg4MmpYYmR1aEZhbWxqcCsv?=
 =?utf-8?B?R1BEZ3RBTGlGRVQ1SFM5dVVhc0JWckxpWnA1RUdORUpUczBIdUhYM0EvcTRu?=
 =?utf-8?B?U2FFTTduZ294OENVY0xuKzJFdWRjeVV5ZjJ4d1RpU2ZMMU9sTWhQK2JxcXBx?=
 =?utf-8?B?M0hjeDVqSG54YWp2VlJjUThmSjFvT0ZMQUtmaFFhV1dHaHNhdll4eG1aam03?=
 =?utf-8?B?cFNQTGd4b0l6S0lrTVZ6R2c0aTFiaU9rRUUvQ3ZQcys2WkFDYmo5TnRrYnJk?=
 =?utf-8?B?TTgrSG1lUEE2NlordC94MUxua2k3bDlmUXRkS2s4WjJWRkxyNFZwd1BpYVpn?=
 =?utf-8?B?b0ExbjNGT3g1cjEvT2dZN3BwUVhGTlJ0RUduZ1ZMU01kcVQxTGFGMFE4N2la?=
 =?utf-8?B?QVpDRDVJTmxhcnMrK04yaUJMLzVDbGtQQndKbXpEQUhCd25MMVBJRnZLT1hj?=
 =?utf-8?B?Vk4zZmhka2J1TG5odDRWdk1DZkYvTUR1c2NqT1VsbEpJS1hPZDFRSldvS25o?=
 =?utf-8?B?Wm9wQmxhUXVNSzFCL1doa21aa0FVcnJ0dDBxZnJxT3RDY2lORlRzYTh3WWE2?=
 =?utf-8?B?UjhYQUZmNXI3MXVrT29sVmlkNi96eHAvWFpuMFBSRGpzSVJzeitDZzVuRElr?=
 =?utf-8?B?YmcyV3RYclZhRXhBcjhZR21zemUzYUkvQzFzcTZvWU1wUVpYa2RIRWQzSWJQ?=
 =?utf-8?B?aytmYXlqQkJCZHdGak1la0VDOWVQdXp1NE5GZENjSytQZlUyZDBTeXZMNGo0?=
 =?utf-8?B?QW9VTC9VTEYrcHBvK2RqWE9ibXZNMHdmNnpkNXhrTzFWNlNYV0dtaWE5TVVr?=
 =?utf-8?B?ZnhPMUVhbkFkWVZUMXkya0taODR3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD6B3431DC6BA8408AAA13359B9FE7A1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RZftEpKY2v3PcO55T/UVfDsZ4bznbVa3R0+yu11sehVAbVb77mndvO5DNMppNWl+AoqHNwkZ7DD9BO8u0RDQMlKCzZzdYX0BtuKZB0thzdWFjd2Ux+4ZDKDVSgkY+SAGzmv9FwQ12nS/LnjfDp8/MtkMclMTn0AyHuXK3SpPAvsSQTPDVHaXbnAyqxwVmD52Rxdalfc0q1xvpqqZKW50tmimFDgdR5Ye+jSSlMy52qEH62zyouptvC+/SPq8EWkApf8GCjshj3nb7V1g65c4M0saVQPCcPWEph59avRhaleoEpRZbYO1Vp5KwU3pAugMs3J/3u29S0qCICLQrxUeWwR8Wo+S5E5t0WJ1zwVsCi0xZgZUI8PZWizWagl9SfHhcINMBydrpUqe+pJivISKiCBW1DMD2ts8cmYrbRIiarJdVc5Ny5ghXxLp9gd6QksidnE7jAI+97sgwFwIA4PLxlhPJq23fEjvTAkCYGh0Ze5JU4LLH4n4e9br5+Jy4plUPid8De2FgFYrCAYbvOI0Oqn4iOISsZoybsDj2+zGbWCg9iQbV0QthJaQay9f7ufZeXmaBjJHN0tnHbdG0UcQrvdjHQM8uN7htGVNqtG3uO2nERCwM93f7kh9EKCVMQEW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed7a640-51ab-4fb5-c9d6-08dce2f1c855
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2024 14:52:05.5386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o3+GzhnvuFk1JLmxSF1ZdA8tmGYuHejXRguK9JWnaSCyIleB5qcvOVSsoOFsgDlenLqQmDPUdOS7+iCZZElB3MxZKvtbinG1GT3Vu1QNOts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7018

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

