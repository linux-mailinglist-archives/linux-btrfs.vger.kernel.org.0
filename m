Return-Path: <linux-btrfs+bounces-11688-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A892CA3F2DB
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 12:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B83FA19C0D3C
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 11:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A4D20767A;
	Fri, 21 Feb 2025 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IdX6jujx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wDg8j3ik"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779A82046A2
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2025 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740136986; cv=fail; b=i9mb3BX061OcTsE71DuVRWXFjukeTjYTruQ4KkN3s6Bz1m+6ICH0ofAPhbdUQuB4qN0vS8a11rtrqFH5CD3zux/Gi56a+Qn9qNKrc5vXvZMdEZbrX0XjCkQ6doq1UTrm2xNeYFqKXo+F95cdr9VCdLVsU+Drf8Ymge9QLB+OfGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740136986; c=relaxed/simple;
	bh=W/T+kZXUeW9tIJBioItZ8iHSu3/cgf8mOkcKJNKCjZM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F1Lxv/Nu9hwp6G0jEN4G5vVEW+UC2muuGbbaKfM8s2GFgSfHWA5My6YClBf4SWpP+50gfsizhUeD5r7Kb/OhKGzqMDYvKUJSRY7JuZMO0LNaegu9xOX6ukZ5Va2PryJP216EMtkZisqx791irWjirQh4YGRgAbgJayr1KoSVmLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IdX6jujx; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=wDg8j3ik; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1740136984; x=1771672984;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=W/T+kZXUeW9tIJBioItZ8iHSu3/cgf8mOkcKJNKCjZM=;
  b=IdX6jujxeHd+LtI8I11+KyAl+ci6XwCoMNAnHHqk/uEyZH/ZoYi+nS8S
   cYgXC78glSUpckoWLDCz82sVptlNGnw/fGlCAYceAgSR1+q+0Z/rs/btz
   GIDaRxkn/Znu1iJ7s8QE/n6g7GJnCoVAbjtdTLJwqPdXy5JGGK0hTvilC
   KBqt/98ptQvNNKpN/VjAiHEfFAVLYznqE/y3c4cUFUKpbWhHopJKZRosz
   x6tu5kDGEAq3r1lXzdVRusG2hsksnMCjimYB7pqC5cK7UjlOYP29lu2nc
   2RxAI8F86j2le1NWhoZE0+Ra9n4w9cDPT2HO3N40+TsBe5cz6bAdSKZ1E
   Q==;
X-CSE-ConnectionGUID: 70OIq08eRmqhDK6ySUafoQ==
X-CSE-MsgGUID: /QdPO43mTjSy5MyijqpJmg==
X-IronPort-AV: E=Sophos;i="6.13,304,1732550400"; 
   d="scan'208";a="38919435"
Received: from mail-westusazlp17013078.outbound.protection.outlook.com (HELO SJ2PR03CU002.outbound.protection.outlook.com) ([40.93.1.78])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2025 19:23:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWGuKaQ9luMsGEb0mGOQP0dEOID352QJ4hBUrIJDO7jYjyq3lYVE67UsQSyf/wnjIgam04YSWNIfM4mJt7YXTaVZ9fA+CYoSL6Y1AO9Y1obgTduWC5WGNwhiPWcptIMHEh7vQ+yA6NtT1h3wC5hC9L7uEu0LOmiTwvWOQ4eRVedHt4enz6vCy5ja1Dz9meYehpfHfABCcT4pGPjc7v6d0Km+NSFpRvH0dxZUgyQrrve+5xNKrpzliDDRxSJmehyl2qF47ZOkvAAQs3pMYx0uyrL3AbKzEUJAmO+8B5enKlZZCw+RDlOCi1IfR6zikOU41J5EONEOv41G7a3wGZBjJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/T+kZXUeW9tIJBioItZ8iHSu3/cgf8mOkcKJNKCjZM=;
 b=Eqvx3ADxy/uz4Fwg305edGK5FzxJnjXT1H/o/hGj9ujJL3q6/sTmUelA2teTlFAYWmYtdDA7kQHnTX3bDaoDjrQT2sr6I5QqnwLaMS1+tEpCrjnCoRqNRS89JAj4AscgKzd/EU9rMG6zXMUYSttVDoH4YQMkQOE/iy0kCcFGRv5GFD3v+yWX8yem7ITdV6FOxl4nOvOk5WltJw2KU28LE+fFknFGrdsJXXXdDWst1K5WI4kEu+HG0TuuAtJx6bRXuGxFVZxsRajppysQ87DxQ5D9ogg7QLQ2pOpns8/Cx3tb9p1Pcj3//lvL11WwizN2YVH0/S7LtsY/8fIGyAUd0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/T+kZXUeW9tIJBioItZ8iHSu3/cgf8mOkcKJNKCjZM=;
 b=wDg8j3ikxEPXidlbG1eUW+u1+z7bKIsYpvy+M8J+ioxloZg0MJ0mp2s2Sn46KNvegapdtUL3nK1HkEt6ZjfNDexeYj4iQ/AJgu5Sp/Zgz8JApEHE16dYqk3CUs2m9q5/znFrQjno4ugvbN+OK/FZ5fpCbpMs2DA1rgrpesu8AKA=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by LV8PR04MB9069.namprd04.prod.outlook.com (2603:10b6:408:267::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 11:23:00 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%6]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 11:23:00 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/5] btrfs: prepare for larger folios support
Thread-Topic: [PATCH 0/5] btrfs: prepare for larger folios support
Thread-Index: AQHbg3mPMfdjy7u6jkqvgt017jH7b7NRnvmA
Date: Fri, 21 Feb 2025 11:23:00 +0000
Message-ID: <c9e1a407-6562-4564-a87a-e449d36b4b97@wdc.com>
References: <cover.1740043233.git.wqu@suse.com>
In-Reply-To: <cover.1740043233.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|LV8PR04MB9069:EE_
x-ms-office365-filtering-correlation-id: eba9b039-51a2-4ab2-804e-08dd526a197a
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SUxMNFBTNlZFdElzWGU0WUlxc2ZWcFVncEFtRm5yamtoNVVJRllBbS9OOXpi?=
 =?utf-8?B?bjB3ZnVZL1V0dnpmT1JqemdtMUdoTEtJUEN5YjhiQnpRcit5OCtMQW5JNEhL?=
 =?utf-8?B?SmpTZVkvdGczekgxUHlqTjE1b25mMVlLWm4weUM5WGdrR2hMTlNIWGY3bUxZ?=
 =?utf-8?B?cDlEY1FoQTNYdDVNWUdkTjM4MThkREV1NUI3Nm1NSkJDV0x3NUlhZFhuYUho?=
 =?utf-8?B?UG5tTUFXZVhUNElVTEczd1lYeVhicEpPUVBMR3BLTk12UG8vQ3NpL0pDNWtS?=
 =?utf-8?B?SktsQU1kU3dQLys3ODBBTGFCSEVKRUoycC90VEwrMTg4VkVycDJ6c2hVQm93?=
 =?utf-8?B?VHpHTnhTMGZua0tLS1VtNjJHWjdadUxkMVEvUlVwNURRcEhnb0QxSVJxQ1Bp?=
 =?utf-8?B?alZ4MWRINWQ0Uks1Y2xyU3d1SFNxVHgwckJQN0VRUUkrd3ZpT0xPeGZ2dy9X?=
 =?utf-8?B?Z2pUV0xpVUd2YUY2cjh2NHh1Y1BwUW9XTVVHeGR3d1JEQWlRSlJaVW94bS9x?=
 =?utf-8?B?SjFhNVRVTUcxYzFhRVV2bmJLSkZ0SUc4aW1talB2WUd0VTZYTlY4LzVBdW1D?=
 =?utf-8?B?TTdzdHRhUmdxUjJQOHFqemdZYVorR1YzTGc2Nzk2S1Zsb0crVEJMMFd5Ly9j?=
 =?utf-8?B?bmpjQ0EwQ2hqVVAxNko4ZFdBaHhNSUl6VjVNaVV1ejRibmcwOXdKcXR4Y1hl?=
 =?utf-8?B?bThDcXE5d1NwbnlMRjgvVHVBVVZRVlh3UE9hcjZlZ0U0dkVoNzlIcTZDUDhS?=
 =?utf-8?B?MXNTOExvaWFRenRYYW5qU1laREpyQ2FzNzEyRkc5S1Zld3E3T0RVazZsbDF6?=
 =?utf-8?B?d1IxT2JYUW9ZM1RzeFVwUnM1MW42SS9RWXgzL3I0L3JTOUdaUVZqNE9WZU1z?=
 =?utf-8?B?YnE3ZWorUjNueGNQUWdXdmNIN0VpU3NhWEplczdSOEpWek9EaXB6NzJLTjRz?=
 =?utf-8?B?VFNaNmt0ZWhwQTlmV0VjSElDQVViN3c0Y2M4NWhZaG5PYkJKQng2aWVtM2Fj?=
 =?utf-8?B?VFNDMmgxKzVReVE4cHVyWXdEdCs4OWR3ZzAwb01BSnNBU1NEL094M1ltOHVs?=
 =?utf-8?B?cnZxQ01lUzBiUitVekp0MGhQQVl5RWR6cUhPWXZXN1FXVVg1VmtNaDVjYTFy?=
 =?utf-8?B?ZlBadHFybUx5dllTUEdhaDRZQ0o4YmlsRnZnQ2VsS0hwNElNL3VRUTVjY08y?=
 =?utf-8?B?NlNVSlBVSVdmdzRHTG91TEpnYWcrVllOZ0V3WGxMaDhOUW5RdHgvWmFVZkJ1?=
 =?utf-8?B?SWdqUkFkNXF3eW45YVlZWmlwdktDT0c0ckxla0s5b1FDdHpIRGQ0S08raklw?=
 =?utf-8?B?UGsrTjlvcW1mNlVYMnUvQ2czcWFSWEx0NHNYNVhiTnZ6U1c2MldmSTdaQzd5?=
 =?utf-8?B?dUpJV2lab0t3ZHhXRjBPMUh0ZmEyRVlZUlJuTWZSWDBuZlVObE5SQUVOaSt2?=
 =?utf-8?B?V2lCdHMwQ3ZvWEcrM3hFT1JFdWJFRndPVEpSc0tha1h3c2F1VG5qSVE4SDJu?=
 =?utf-8?B?SjV5MG5nOWFaTG9LaCtHY1lZOUJJVUliSGxaU1JSSjlURGVKRlRMRWMxa2Er?=
 =?utf-8?B?NGs1QllhVktCeC84alJ0b3hpZWpEZzVVM3IyRENnRVBiNjRIWTdjaE1lNlZo?=
 =?utf-8?B?OHAzMHpkRk1jekQwZGRKMmI1cFg4TUk4dXV4Z2g4QlhtL1hRak4yRCtFSmJ1?=
 =?utf-8?B?YXpnaFFjV1BQYTNMa2tSQWtmUUxtOVZGbktQdWdaSncweG50YjVuNnE1TFJi?=
 =?utf-8?B?Y3NiU2JGclA2eFhZMUdWQUl0V0NuOWEvL29ZeUh3Uld5NFhJS05yMmlDNTZ2?=
 =?utf-8?B?alcrRHFOVWRGNU5Xa3dTV2lXSzZlcWZ4Vk9RWUVCbkxWTURSYXRxTXZlQkRl?=
 =?utf-8?B?amFSWXJzU0FuRGN5cWVTZlp3VUpibytEcnUzMXllRGlvOCswM09kQXAwNFFB?=
 =?utf-8?Q?VU+LZev+96w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ti9vZzhjTk1Nc08yTjJ0ckFIR1ZweEM3cUd2Q2hxVTdGaWRhMkVaeStVa2Rn?=
 =?utf-8?B?cy9sNE1hWTdwaDRrQklkNElLYzNmbFd3M3cvcjRPRUhNQjRZOFVBWkZIay9I?=
 =?utf-8?B?RGxvcTRuRExsbW8yZzIrUlVQTXlhRnM0TGlpQ0xLdWNuelZ1bVZUVDJYU1dr?=
 =?utf-8?B?MXM3cEdTT1BRVEV1ZUxoa1FyRFZOdHAyWUtqejBZeVZwT1BhbnpqU1ZpUzhl?=
 =?utf-8?B?dWRZV1hDbHV4cGJzN0xleHlpQ3JvOHNMWElyTGNrb0EzZi9lVXEyT3E1dGd5?=
 =?utf-8?B?dlpXeFVFVTdNY1B4ZmkyT2ZkUkNHRksrNEFEeXBiZ2tzb2VROGlud01xcVp6?=
 =?utf-8?B?WkRLL3RaVzdPTm9qV2N3MGxYdzFxRXJDN3g3c2dlNlZPZWZ5Z3NlbXJoVnh4?=
 =?utf-8?B?T20wUncyMFhLMTM3RW8rWTJRaEdRUVVlbVJnOHlVcVpoNnowRW1BMzUxb0pj?=
 =?utf-8?B?V1IwQ1BmRU4rNG14RkFWV01yZDJKQ2RBMGhWRE1wSXRILzdmdndMNzJSM01m?=
 =?utf-8?B?WlpjNmQ5K3BVdy9oekVDbjF6bmF3eE1ud2tobEdOaHFWNCtlbkIzZE1XTE5B?=
 =?utf-8?B?d05SMWM0bEhubU1kZHFTRUhFRDJ2cDk2bko5d3F6U3BqUkhqWVZmSE5NeFRE?=
 =?utf-8?B?KzRwNVdCdFFiK2tuTitTeHVSNDlUTHhJMndDcDVzM3F1VURlbm1SdUNZaDFR?=
 =?utf-8?B?Z3RZNHI1d0V3Q042VGJxZE4waGxZZUxNajVNbk11b1QrUUNKMTBRY0MrSHlY?=
 =?utf-8?B?SHZ4K1c0MUJ0STlobTJOdXByRWovVFliMkNpa0ZBSlkyRGxXamxiZERtN09M?=
 =?utf-8?B?QnNRT0ppY0hVeHRSUER1NkFxMmNnZ1VqQ1N1S1QzQkM0bk52SXk5TkpVZTdY?=
 =?utf-8?B?Y2FQZXRtOHZ0d1psR1UxSVA1aGRjVGs2UU5EK1pxSXY4TWxyYlRML25wZzU1?=
 =?utf-8?B?RFhiREJFVmlYbDViR0h3M3pEMFRPb0N2U0QvLzJLUXZuYUhhNmJYOHdCbURU?=
 =?utf-8?B?NnlUUGErbnZiaUR2QlZaY1BiZnhNMGQrU214MTAyNEtKN2ZscEhoS2tNZ2R6?=
 =?utf-8?B?RnV6VnFGSHBBQjdsRkpRSE5zUGNFa1pnR3hyZEVHclZXNG1qaFlpMWlJdkdw?=
 =?utf-8?B?WXlDTUt3UGlFOFBlM1VHaUpHU3hTVXg1SXBCdmNHK2JYWUVBYlJ6ODVYVEtD?=
 =?utf-8?B?c2syVUNkTjZ0VEo0RGI0TDg3TmRTSThScFlSVXo2dW5lS0VaS3NlU1BFVmJx?=
 =?utf-8?B?NFgvdWNlYXhKYjNqOC9QTTd3YTNYeDJKdmNSd2l3MXpxMFZ6WFE0UFo4cjRX?=
 =?utf-8?B?a0pLS3hiQys4c1hlTnhGUm9sRVM1UUVCNWVFTlY2OVl2elVBRm1vRThSakFx?=
 =?utf-8?B?R2t3ZFNndkRYQ3R6U0tBN0Q5ZXlYdGlHYTVQakxBQXZSc3pTWkVpYmo0ZXhz?=
 =?utf-8?B?TzRWV2Y1NUxqRTRzZW8vamt5MVEvamZ6aUZ3M2x1WFMwb2dBK1ZyRWZ3R3Np?=
 =?utf-8?B?UzNWWVJxNndlMjhTUEhHTzNVTTZLanIvb2YwZ25VVmU1eDZtM1ByTDNNTG1V?=
 =?utf-8?B?VHRNSHFPWkRwUUExOFJjaTVvaVhvWTh3azVDZ2hQZy82bnJXU2prcUViZjhq?=
 =?utf-8?B?NjR6Ui9kQjhxTGNkMktMUS9kNktZVlMvdWZpb2JFa2JvMmxRVXk2NFlOZnc5?=
 =?utf-8?B?U3cwS1p4MXZXaFVrdkRiNUc5enhSUnZ4aDU2MmhuZnFYVFUvVlRqeS9JQlMw?=
 =?utf-8?B?aDB4Rlg4UnNiSHZyWldOaStsMS82eEV1T2JGeVQvYzA0RXl1N25qa2trL3dn?=
 =?utf-8?B?cEl0Zi9MWkkycWNzLytVWlU4QU4xdnhMVUYzNUtjc2cvR1RDM1ZPbFMzZW44?=
 =?utf-8?B?OHRzek9sZ0VMNXZLdXdWekJBTGNQaXRXZkRBakNpTklpSXlDUERLZXFNbGQr?=
 =?utf-8?B?cDRDMnptMldiVXF2TTUyS1pVMkpJTGE2dW1UM0RGYlM1eUlzd1F5azk1Tlo0?=
 =?utf-8?B?WFdHSitPdXNnL1Z0b2RCSXhvTUc4cTBRUmJ2TklTUE1KMkc2dVk3aDQvNytG?=
 =?utf-8?B?dGdRWnQvMHJkNG9RbHhKeEtyU28zQkhudGNrYm4zRExzaTBqV2swMTZyRGlI?=
 =?utf-8?B?NW5yVk9EL1BsbElKc2VDWVN2ejZTVWI3WEI3M0VtT1c3Ykc5dW54WXpvaDdt?=
 =?utf-8?B?dG92OHNJcVFFOWZQMEVxaUN1TDF5SXpXV3Y1MXN2QmVXWGU0TEhrSitmNEJM?=
 =?utf-8?B?d3FqNlFkZ1kyT0lXUldOMmJzWXpnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A56EBAFB4E56742843CF889D2AB723F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	u7zrZcdLatM9xFRZKeyBClWMkIiBHc8etEFMde1B2FB3OJAK29KcXjf4SMfLxKf7DQrsumjRd/BRPRzf48CFDtJJl0Md/8yIlYr0PK0vXYeSefJrc/BHhmNzEbkF4U3gVAMRu2KCk+Fmq2YOoF2WsMJpDJEQNJjtpZvaoudEIcZqdGGsFcUMvF782F7KPy0mo0RdIXIBi7VQIGjgA/9TcA3PBiz8X1LJERuvE7i+E9+ndMMLbCrOgNkl4VCG0l5BWzFzjwqGEkGbcFvnGu4UNr5/dRvhfcKqaF42xCD+T1aSY6LbUvWfCTxMjqdGUfLUhtWnrqZ3bpbe7+xP5PfWPjtOIglN2U8bXxPcWvizEVlfc3PO6Bsac6EMXyBoRMjL4qgRAOhhMRDbRk8JyowoRdFq4udrN/yH1w3a2Gd8MBtEkpn1pYM4Q/BRuwAPfNGgUj12SpLCgmV15SHJw0c8EhbSG7TzDQ+JAJI0Zvw24GVJNWuBuJhdE/1GZ+/L+Lm5yyvIl+ZJTHJNTX/HAXnOhp4YSS2yFEVHfaVdFWWaMtB9OZ8c4NlMXhwCoB8Q9WZP9yBhsXmZP1S4CrbbtlBqg2XFb0LPE8Dxm35oGOlhteWLZcZsXH/7EKwUn0FdPF5a
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba9b039-51a2-4ab2-804e-08dd526a197a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 11:23:00.3699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ACqopp6IC4UHyfiBSG4mrxOmlIDUxJ6XsW/8DGsgGPo3pIebfiu5T+yJR7i/dYYLuXBl++uhnfYJRThcZUj6q/Am6Lzsq/aT0rr8w4ZgcG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR04MB9069

T24gMjAuMDIuMjUgMTA6MjYsIFF1IFdlbnJ1byB3cm90ZToNCj4gUXUgV2VucnVvICg1KToNCj4g
ICAgYnRyZnM6IHByZXBhcmUgc3VicGFnZS5jIGZvciBsYXJnZXIgZm9saW9zIHN1cHBvcnQNCj4g
ICAgYnRyZnM6IHJlbW92ZSB0aGUgUEFHRV9TSVpFIHVzYWdlIGluc2lkZSBpbmxpbmUgZXh0ZW50
IHJlYWRzDQo+ICAgIGJ0cmZzOiBwcmVwYXJlIGJ0cmZzX2xhdW5jaGVyX2ZvbGlvKCkgZm9yIGxh
cmdlciBmb2xpb3Mgc3VwcG9ydA0KPiAgICBidHJmczogcHJlcGFyZSBleHRlbnRfaW8uYyBmb3Ig
ZnV0dXJlIGxhcmdlciBmb2xpbyBzdXBwb3J0DQo+ICAgIGJ0cmZzOiBwcmVwYXJlIGJ0cmZzX3Bh
Z2VfbWt3cml0ZSgpIGZvciBsYXJnZXIgZm9saW9zDQo+IA0KPiAgIGZzL2J0cmZzL2V4dGVudF9p
by5jIHwgNTAgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0NCj4g
ICBmcy9idHJmcy9maWxlLmMgICAgICB8IDE5ICsrKysrKysrKy0tLS0tLS0tDQo+ICAgZnMvYnRy
ZnMvaW5vZGUuYyAgICAgfCAgOCArKystLS0tDQo+ICAgZnMvYnRyZnMvc3VicGFnZS5jICAgfCAz
NiArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tDQo+ICAgZnMvYnRyZnMvc3VicGFnZS5o
ICAgfCAyNCArKysrKysrKy0tLS0tLS0tLS0tLS0NCj4gICA1IGZpbGVzIGNoYW5nZWQsIDY5IGlu
c2VydGlvbnMoKyksIDY4IGRlbGV0aW9ucygtKQ0KPiANCg0KSGkgUXUsDQpXaGF0IGFtIEkgZG9p
bmcgd3Jvbmc/DQoNCkFwcGx5aW5nOiBidHJmczogcHJlcGFyZSBzdWJwYWdlLmMgZm9yIGxhcmdl
ciBmb2xpb3Mgc3VwcG9ydA0KQXBwbHlpbmc6IGJ0cmZzOiByZW1vdmUgdGhlIFBBR0VfU0laRSB1
c2FnZSBpbnNpZGUgaW5saW5lIGV4dGVudCByZWFkcw0KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC4v
aW5jbHVkZS9saW51eC9rZXJuZWwuaDoyOCwNCiAgICAgICAgICAgICAgICAgIGZyb20gLi9pbmNs
dWRlL2xpbnV4L2NwdW1hc2suaDoxMSwNCiAgICAgICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRl
L2xpbnV4L3NtcC5oOjEzLA0KICAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvbGludXgv
bG9ja2RlcC5oOjE0LA0KICAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvbGludXgvc3Bp
bmxvY2suaDo2MywNCiAgICAgICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L3N3YWl0
Lmg6NywNCiAgICAgICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L2NvbXBsZXRpb24u
aDoxMiwNCiAgICAgICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L2NyeXB0by5oOjE1
LA0KICAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvY3J5cHRvL2hhc2guaDoxMiwNCiAg
ICAgICAgICAgICAgICAgIGZyb20gZnMvYnRyZnMvaW5vZGUuYzo2Og0KZnMvYnRyZnMvaW5vZGUu
YzogSW4gZnVuY3Rpb24g4oCYdW5jb21wcmVzc19pbmxpbmXigJk6DQpmcy9idHJmcy9pbm9kZS5j
OjY4MDc6NDE6IGVycm9yOiDigJhzZWN0b3JzaXpl4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBp
biANCnRoaXMgZnVuY3Rpb24pOyBkaWQgeW91IG1lYW4g4oCYc2VjdG9yX3TigJk/DQogIDY4MDcg
fCAgICAgICAgIG1heF9zaXplID0gbWluX3QodW5zaWduZWQgbG9uZywgc2VjdG9yc2l6ZSwgbWF4
X3NpemUpOw0KICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IF5+fn5+fn5+fn4NCi4vaW5jbHVkZS9saW51eC9taW5tYXguaDo4NjoyMzogbm90ZTogaW4gZGVm
aW5pdGlvbiBvZiBtYWNybyANCuKAmF9fY21wX29uY2VfdW5pcXVl4oCZDQogICAgODYgfCAgICAg
ICAgICh7IHR5cGUgdXggPSAoeCk7IHR5cGUgdXkgPSAoeSk7IF9fY21wKG9wLCB1eCwgdXkpOyB9
KQ0KICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgIF4NCi4vaW5jbHVkZS9saW51eC9taW5t
YXguaDoxNjE6Mjc6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhfX2NtcF9vbmNl4oCZ
DQogICAxNjEgfCAjZGVmaW5lIG1pbl90KHR5cGUsIHgsIHkpIF9fY21wX29uY2UobWluLCB0eXBl
LCB4LCB5KQ0KICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+DQpm
cy9idHJmcy9pbm9kZS5jOjY4MDc6MjA6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJht
aW5fdOKAmQ0KICA2ODA3IHwgICAgICAgICBtYXhfc2l6ZSA9IG1pbl90KHVuc2lnbmVkIGxvbmcs
IHNlY3RvcnNpemUsIG1heF9zaXplKTsNCiAgICAgICB8ICAgICAgICAgICAgICAgICAgICBefn5+
fg0KZnMvYnRyZnMvaW5vZGUuYzo2ODA3OjQxOiBub3RlOiBlYWNoIHVuZGVjbGFyZWQgaWRlbnRp
ZmllciBpcyByZXBvcnRlZCANCm9ubHkgb25jZSBmb3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJz
IGluDQogIDY4MDcgfCAgICAgICAgIG1heF9zaXplID0gbWluX3QodW5zaWduZWQgbG9uZywgc2Vj
dG9yc2l6ZSwgbWF4X3NpemUpOw0KICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIF5+fn5+fn5+fn4NCi4vaW5jbHVkZS9saW51eC9taW5tYXguaDo4NjoyMzog
bm90ZTogaW4gZGVmaW5pdGlvbiBvZiBtYWNybyANCuKAmF9fY21wX29uY2VfdW5pcXVl4oCZDQog
ICAgODYgfCAgICAgICAgICh7IHR5cGUgdXggPSAoeCk7IHR5cGUgdXkgPSAoeSk7IF9fY21wKG9w
LCB1eCwgdXkpOyB9KQ0KICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgIF4NCi4vaW5jbHVk
ZS9saW51eC9taW5tYXguaDoxNjE6Mjc6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhf
X2NtcF9vbmNl4oCZDQogICAxNjEgfCAjZGVmaW5lIG1pbl90KHR5cGUsIHgsIHkpIF9fY21wX29u
Y2UobWluLCB0eXBlLCB4LCB5KQ0KICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICBe
fn5+fn5+fn5+DQpmcy9idHJmcy9pbm9kZS5jOjY4MDc6MjA6IG5vdGU6IGluIGV4cGFuc2lvbiBv
ZiBtYWNybyDigJhtaW5fdOKAmQ0KICA2ODA3IHwgICAgICAgICBtYXhfc2l6ZSA9IG1pbl90KHVu
c2lnbmVkIGxvbmcsIHNlY3RvcnNpemUsIG1heF9zaXplKTsNCiAgICAgICB8ICAgICAgICAgICAg
ICAgICAgICBefn5+fg0KZnMvYnRyZnMvaW5vZGUuYzogSW4gZnVuY3Rpb24g4oCYcmVhZF9pbmxp
bmVfZXh0ZW504oCZOg0KZnMvYnRyZnMvaW5vZGUuYzo2ODQxOjMyOiBlcnJvcjog4oCYc2VjdG9y
c2l6ZeKAmSB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gDQp0aGlzIGZ1bmN0aW9uKTsgZGlkIHlv
dSBtZWFuIOKAmHNlY3Rvcl904oCZPw0KICA2ODQxIHwgICAgICAgICBjb3B5X3NpemUgPSBtaW5f
dCh1NjQsIHNlY3RvcnNpemUsDQogICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXn5+fn5+fn5+fg0KLi9pbmNsdWRlL2xpbnV4L21pbm1heC5oOjg2OjIzOiBub3RlOiBpbiBk
ZWZpbml0aW9uIG9mIG1hY3JvIA0K4oCYX19jbXBfb25jZV91bmlxdWXigJkNCiAgICA4NiB8ICAg
ICAgICAgKHsgdHlwZSB1eCA9ICh4KTsgdHlwZSB1eSA9ICh5KTsgX19jbXAob3AsIHV4LCB1eSk7
IH0pDQogICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgXg0KLi9pbmNsdWRlL2xpbnV4L21p
bm1heC5oOjE2MToyNzogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmF9fY21wX29uY2Xi
gJkNCiAgIDE2MSB8ICNkZWZpbmUgbWluX3QodHlwZSwgeCwgeSkgX19jbXBfb25jZShtaW4sIHR5
cGUsIHgsIHkpDQogICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn4N
CmZzL2J0cmZzL2lub2RlLmM6Njg0MToyMTogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKA
mG1pbl904oCZDQogIDY4NDEgfCAgICAgICAgIGNvcHlfc2l6ZSA9IG1pbl90KHU2NCwgc2VjdG9y
c2l6ZSwNCiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgXn5+fn4NCm1ha2VbNF06ICoqKiBb
c2NyaXB0cy9NYWtlZmlsZS5idWlsZDoyMDc6IGZzL2J0cmZzL2lub2RlLm9dIEVycm9yIDENCm1h
a2VbM106ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDo0NjU6IGZzL2J0cmZzXSBFcnJvciAy
DQptYWtlWzJdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6NDY1OiBmc10gRXJyb3IgMg0K
bWFrZVsxXTogKioqIFsvaG9tZS9qb2hhbm5lcy9zcmMvbGludXgvTWFrZWZpbGU6MTk4OTogLl0g
RXJyb3IgMg0K

