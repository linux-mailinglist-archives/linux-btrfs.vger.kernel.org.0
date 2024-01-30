Return-Path: <linux-btrfs+bounces-1935-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB2584238A
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jan 2024 12:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7440B1C245C8
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jan 2024 11:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFFA679F0;
	Tue, 30 Jan 2024 11:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e84MnYg6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ciFZ30hL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2C76BB38
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Jan 2024 11:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614956; cv=fail; b=mOavEqjv7xz1xw8IwsgoOjS8JfouxUYtWCdudJZZaGm87bG8/IE2WSwjMgXTKlGMeuqhZ6HFdQc5q/n7s7N5ORuMX8p3z2fk3PxNlu/rzw7kZtY80CSZ0hTPnzuGR9GbZ4HlAEpr2UFpcwErDPHg8XF/CdX+woyeaft8EvKwYMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614956; c=relaxed/simple;
	bh=PD3YzLBOcINshlniz/C4Bd4PKNqjzmbuJvhsKnPr54c=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TDT75Ao326QuzuPrhcS+oQK4wHf7RH8Cy5teeS8Yygsi/6rLdOEiRNXA+0Y5PKxmQduHpawDMPKwLzo81c91+vn6e8WAg6uAFe5xFtpJAUxmdZu8eSXQ/kdrk+QsWCAfhjrb9YMvZu7bLLrlsr3rxEkfgiTtDngG172FHPbK0/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=e84MnYg6; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ciFZ30hL; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706614954; x=1738150954;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=PD3YzLBOcINshlniz/C4Bd4PKNqjzmbuJvhsKnPr54c=;
  b=e84MnYg66yFCCr7rlXvEFAoguS4AYMD/mEvlVah+KA5JKSlrvrqE1UPu
   KKTksxf15rGue2nzZPpxMcpH4SS9gZwGGZQV9dh3guIeg6QuD5Ei3HLV3
   kMKJHfbOoY5EZC2DrqYJJbcDEQfhblYumeVXwMj9nZc1OyMs4zL0dLaj2
   3gaQOaVbu0U4GYa4d+Gdv6cintyFAhIPEUGcNNNQce+QWnhODEQ798KUG
   mmQChtJo7JTAcW4mXm/afD6uoQLNBf/ewOqqwIRe193WDDe/zsfYffu4u
   MZj9XM7N+IV/EScaBTLcBQHvFwnO0C4+rp8v1/x31tOgJflckfjEQdfbl
   g==;
X-CSE-ConnectionGUID: kFYG/3BLTHCHp75u70tVZg==
X-CSE-MsgGUID: JtYg8XgCSnuO2vhD/WSJ6g==
X-IronPort-AV: E=Sophos;i="6.05,707,1701100800"; 
   d="scan'208";a="8066154"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2024 19:42:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIHQgC0mpjNKM9SfeW6ETXHWF1yGAd2HbAOt0yBpDwTXg9df8jgFjNYuH3ovIFzmUBNvWYe8E+EduYDOFg9SSXt3QBnDfpzuahP2qyEhoKaZJA55081KNcRYojjYPF6qx86pRE/KPreiKIxR6Ff146ZwFby9ebhG+wt6nCj6nPafToTzN6svi/OETtDexWb+5uGvxSMW9GYVntriSmU8MPRyZGjTEuhD8Xb+L+fqN8F8r7ffu2HWb94T2JqsJLtXIRKORtpDLHOEP09Gj/6jLDaOXFyBOz7DRfvKTEoOJ8XTdj4SlYzUjmwwn0f778SdQsdt9fr47VNiBWJQVbOBJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PD3YzLBOcINshlniz/C4Bd4PKNqjzmbuJvhsKnPr54c=;
 b=My6w45behleXZDhogJ1eZMztHfXLRgjuqXqEexIb6c2dkdtStNmggWh5z4gRdPLpsELzpIjpWP8oFiYBnGzWKNK6aSrpHBH8/nmEvcXrc35FGkloWcma4/IzaMxl/MKVrvO6xfIcyMQXdb9s6hS8bJaZ699MafAQfU8O1/UZyreqDu0zjVhAXbHkAjdSZrfaUMMdN9oGemOgeC0QwIhxq7H7q0K5mhEjUU712sGokd4rHdFWJU/mGWZA/CPMXAeGcX/MfotVrPY8VO+/bobswKEmtX1MM4iEVVuzjtfwMZv2IwUr2ZOCLN0ARIaR+uJp8+aeNpfV1rqZLB0Cc5M23g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PD3YzLBOcINshlniz/C4Bd4PKNqjzmbuJvhsKnPr54c=;
 b=ciFZ30hL7SHbWcmkBNoQqheivw8Jukz2SgNaTniq2JvKBBgZYhNl/BvAIkfsuR5Kt0uTL93sqsvIT21KBble0TsR98mnxPaDZ1gMYu54fmdiUOdbkTU7Rg34LMYBFT2iJiqWjYiglv3VfVv6ftENBvtuEf7K4NFQfyNRwiaMRQs=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by MN2PR04MB6349.namprd04.prod.outlook.com (2603:10b6:208:1ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Tue, 30 Jan
 2024 11:42:30 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::a8a:ec30:a6cf:8e1f]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::a8a:ec30:a6cf:8e1f%5]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 11:42:30 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: David Sterba <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/5] btrfs: add helpers to get inode from page/folio
 pointers
Thread-Topic: [PATCH 2/5] btrfs: add helpers to get inode from page/folio
 pointers
Thread-Index: AQHaUuG57pjtgwND0ESmOAy2ke5/wLDyPQwA
Date: Tue, 30 Jan 2024 11:42:30 +0000
Message-ID: <f5b412f0-9c06-4c3a-af47-d3077b79c2f6@wdc.com>
References: <cover.1706553080.git.dsterba@suse.com>
 <86448b99cc16046569c38cdef83c41afcd8047ed.1706553080.git.dsterba@suse.com>
In-Reply-To:
 <86448b99cc16046569c38cdef83c41afcd8047ed.1706553080.git.dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|MN2PR04MB6349:EE_
x-ms-office365-filtering-correlation-id: ac9e1092-d112-4bd2-14bb-08dc21888ab7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vsYDIO6YxHSDpVjpXK+xkrExOBX/KYY7+D3SUT55m9cHyzSlu4OJ47+aQ1gXx/cYTswMhpCH+M6K+O42sreRSCpbl7+ru+0WhdTkDOxFxpznL6w3VuRXIbG/zImrFcbSrLIHbGgSSVnCwodRKQKINu2djG5OhdaSsewVZTfxYDoSbt1Znc7hqth8v2ayV50YDNcaAih/yK7XBpaFxCN8lsclmS7rNgI431hYheUIzukM/V3ibaMRzqs7X4IwozRM6LGSdNWhLf+tInBuoyrwde1B3d0bOQ1w9SLF1bOUUCf+M+7HB3WtuRQ5XndSaSgXxM9lbLF9sOoyyqYDgKUNJ5oPfinS7+JIst1E3s1l+kJcvshB3P1k4bPhOLN8EvaoC7XznmeO33EK2HxPoLzp0pYEgjIzknI8ISRQ5nAFOiNB9X3tny4OW6wB+mvmfYrp83Eu879MUQEgXnPLjncYtSjO+0e4yJIsmM1iL3Krbb6W4ivzI9KAoQucY0d/QiD82BiV193sZ4rjA0Ss7swC8SufekQE0Qph/Wuh3E41XTQJBtgbZ0546psClTt5Rav8EWBnkZIUxGWUW2ndJXrgaq0F1DOvAgJ2yXUvakbzvOgG6xir3BLiIk3tWiwsODox5xDesuoC3uu634VgqtqpDgZmF7pgvEnZCbUBr0zIRjPqejZMzGdMgRx8QG0K0BSf
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(2616005)(41300700001)(31686004)(316002)(38070700009)(36756003)(478600001)(6512007)(6506007)(6486002)(53546011)(83380400001)(71200400001)(38100700002)(82960400001)(122000001)(64756008)(66446008)(31696002)(5660300002)(2906002)(4744005)(86362001)(66476007)(76116006)(66556008)(66946007)(91956017)(110136005)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUVLOGQ5dEFVWm9VWStjNDlqYW1yY1I3YXRUQTJCOWs2ZmUrWmRUZmo0R0x3?=
 =?utf-8?B?dGk4Qm1aVFFWZHBvcjRaeExjUXNRd2tZRmdhZVVOS21adkkzMCtmYXQrZXFY?=
 =?utf-8?B?UC9qMm4vVzM3WDB3eUV3aTVJajhXcW1sNmU2U0NZMmZhTG9GYUZucS9mdUVv?=
 =?utf-8?B?bG0vUmZsdXZKbnFXNW5hWGhUekIyajA1N0R4NEZZMlZiako3Mi94ZUpoY1V1?=
 =?utf-8?B?ZzgvaEJMd2h3WHhDdjEzOE5qMXVxZGdqRXE4WExVSVBocnF5cC96c1NHZlZC?=
 =?utf-8?B?NEJ1aUxzeUMySUJiVks5cW5IZFhlQUttdHpmMlgyc2l2S0JhSXY4UWwrd2tl?=
 =?utf-8?B?Y3JOTUpha1VOWDBubzFtSlprNldjcmEzMDVkSUR0bWV2ZFJ2MGhhMm1TakZ5?=
 =?utf-8?B?TGx0UzRGei94dDArYzdpUk1semxySms0L0pxUDJvR2xybTdIZjBKUW4zK1hq?=
 =?utf-8?B?eVN3WGxLSC9lOS9PQStrNWRxTUIxQk5YRFFMczRpTGltM3YvSFMwVkd0N3ly?=
 =?utf-8?B?OUprSWlxRDBKRXhaRGo4Rk0yUXh0QjJwZ2U3QS9FWjVXaHNrbjdpVlZ0Q3dy?=
 =?utf-8?B?NE5kUU9JWHdpZ1gwU3FYTFlaMGZ1Nmphczh0cDV1RG5SZkVrcnMzRkRkajd3?=
 =?utf-8?B?ekxpMU9iOGt2NXAxN0FFSzhreWw4S2h0bDNGSjVad3pCb0QwZTZlYUc1VlBO?=
 =?utf-8?B?QnJSeXk1RDhON0haazFnU2UycVZDaDAwUE5ucUEwZ0FCemkrMWVTUUkxM1or?=
 =?utf-8?B?aDhrUmdCcVFselVLM3ZoOVF4Z09SYUNmWUpNOU1jdjBhSVNVcnhTR0VHbzA2?=
 =?utf-8?B?RDBpajEwNEExYTUrV3kraHA0NHdVWXU5QkdHOUMyVWpHdGZRcWdmNnJDekpV?=
 =?utf-8?B?anRHbjFxVmFxeEVkblFIeUlJUUU4NjBSOGFrMmVvS3d5aHhFUzhWYS9hMWtQ?=
 =?utf-8?B?aFBPclhCT2VaYVhCWXhhQWc5M2R0WjkwSGhTVkZZSkFmaElBUVRzendaNVFz?=
 =?utf-8?B?VWVuZEpqb2VRMWdENm9oNjRUWFFWVEpTcW4xNkV4TFVmK0lob1gwZUVFTm8x?=
 =?utf-8?B?QkpWZU1lT01XdkRXYnBXdlcyL0JwaHRVbU5nVFl5bnNGUklheUtSMStQQUxy?=
 =?utf-8?B?WmNoTFBheGpRUTlHQ3pBUDBWTWRGUW0wYU9qOGJ2NVkydE1sQ0RXUElpSTFo?=
 =?utf-8?B?SzNUeXdEcVFCclNLQVpmZWU1azdHakxPcC9Od1VHeSsvdm1aTmJvRVhoVkpj?=
 =?utf-8?B?MWVrMlc5aVdxdEIxU1hKb1lZbmk2OGtRWmRIYXNDellHeFAzZ2NZd3EvS3lC?=
 =?utf-8?B?SnFmcHg0Q2Q0WWwyY00veXBybGtkbllrSzY0U0NSMHJWWWRoM01KeDkvanp2?=
 =?utf-8?B?SitvbDBHMUxienRhYmt0U1BxdnhnU2VFQVdIQkZnbS94UjFrTXlWM0JMeHpx?=
 =?utf-8?B?UjhMcDNQSkhoR0pCUU1RSVUxYnNUMC9ra3JhNkJBdDUzY2xRT0psbm5mR2FI?=
 =?utf-8?B?L3AzWkhzSWRNOHRNZmkxMG1telMrY1BoNVJWQU0rNmFrMXZJbjEvczIyUUtG?=
 =?utf-8?B?OENoemFTSGZtWElmSzdqV1lYWS9CQ202dTlqbm1oeHhjVlIwT0lJbHRQWWhi?=
 =?utf-8?B?Mm5XUDM2N0I4aEJhL0NadkM5OHcrUUE0MUFCamx5WDNHeTRMUm40UDhPUWF3?=
 =?utf-8?B?YXM3SE8wSEhQZWVxUHFEckxrd2p6b1ZOejFGWGZ5ZHltamR4eTZYUFQrdU9F?=
 =?utf-8?B?MjZuTHNIT1FiUDJBUHFERmZtN1QwKzJmd00zdnJUaGE1cXRqVlcwUzg5TFBu?=
 =?utf-8?B?MXhqVHpmczZHTUREWkdsc283WXVkT0RST0ZpMDB3M0JoMEd0VjJSM1g0c2tn?=
 =?utf-8?B?MWdZREVMRk9jeVlUeFpVWStVVzVWQU94UlhldCsrSVprdDhpUTh1OUNqK25m?=
 =?utf-8?B?NjdWUTdvWHNlM0pFck5pNUNadDJMelI2dXBaN1VoMy85bjlHSFJDdjNXUGo4?=
 =?utf-8?B?OHFEck1rUkoxdElSb3JzZnFnT2dNbGlPd1hkY3RoMEFGM3hyS3lqSE15TXow?=
 =?utf-8?B?YjBqN3F4V1dNK2RYRGlNWUJVS3RBV1lNdXViandkOEI1cGVkSUU1RFhmUnRm?=
 =?utf-8?B?cENFdDRSRXNCcUpkSXhMbms1dWg0VW5UaTFQYiszWEc5R2hzcE9IU0J2ZFh3?=
 =?utf-8?B?U052TnFrRFFET2RjbVJFNGhRNDU4YlZ2UFJMZW1zeXl6Tkh4aU9CRDFxVjZX?=
 =?utf-8?B?a085TWN5UzN3YUdsajNGWG5UYWtBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <883D279C6C7B6244908FFD3B8C3A5CFA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p+k6lBre/YScQ4If6oK1qjVYSAy51oPJxGXtZZidIabPYBM5xHQiyg6uT5fg2w9RWPCPZvj0lPxPg5MXt2/ILmuxckPy4GF9qGY4n7G/RfEr1Ys/zXYaNsU0FhWxHYN309NIilq+JXIQ9wCiuFA9PJ1l2TuV2gay8/X91q6YYISgik5EA5afpj/th3jDxHjts+JwC98EcsEfe4aazbp+YWltTLDaChjX1TP31ww14kfd3qofz3x+j5Q8OPB0EwI/wN6BBLyGv0kwPmJV8thd57LkCA1ZPqF37T7G2oclOiv2ieGKjFtnJclGCWnIcsqa8OVbOfkZHeQAqCZsoFexEorfa7iE5kBs8wLRgBiImvI933RBg238JqpShKacyiioCeb/6wz7u/Bz9X/EnDNUOP+qlz6WQJgYsjNA9puS7+4lTGPGZJyHtHiRR4f3IJjltoCjRKM0CHje2ut/59GLLmz0KK0r7HGQhbm4/HPg6SOKa7KHV2YX3Bq48iaZLx6HBTjMhKIUhzgc0puaf2xUEJSiBXyfNf+ehDOTd7m7tX34FbETUWHMJ7/uk59tYukpKF8OT9eRDoNashAU2gqTe/3Y0gzLzC0NZnWBGyfBlOlXggkP12JNL5OjCWuhLQ9G
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9e1092-d112-4bd2-14bb-08dc21888ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 11:42:30.5725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ULmyqMQ4Td5/LCByr7IH8glNgBhcCUODus2yHh1mNoQFbo8LfhZEMiVIyoTN8skTGqZIzikIe/1ItHj7//5hwzkNESq/5tgeNLrRFtkfmlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6349

T24gMjkuMDEuMjQgMTk6MzMsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gZGlmZiAtLWdpdCBhL2Zz
L2J0cmZzL21pc2MuaCBiL2ZzL2J0cmZzL21pc2MuaA0KPiBpbmRleCA0MGYyZDlmMWExN2EuLjhi
ZTA5MjM0YzU3NSAxMDA2NDQNCj4gLS0tIGEvZnMvYnRyZnMvbWlzYy5oDQo+ICsrKyBiL2ZzL2J0
cmZzL21pc2MuaA0KPiBAQCAtOCw2ICs4LDkgQEANCj4gICAjaW5jbHVkZSA8bGludXgvbWF0aDY0
Lmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4L3JidHJlZS5oPg0KPiAgIA0KPiArI2RlZmluZSBwYWdl
X3RvX2lub2RlKHBhZ2UpCUJUUkZTX0koKHBhZ2UpLT5tYXBwaW5nLT5ob3N0KQ0KPiArI2RlZmlu
ZSBmb2xpb190b19pbm9kZShmb2xpbykJQlRSRlNfSSgoZm9saW8pLT5tYXBwaW5nLT5ob3N0KQ0K
PiArDQoNCldoeSBhcmUgeW91IHVzaW5nIGEgbWFjcm8gaW5zdGVhZCBvZiBhbiBpbmxpbmUgZnVu
Y3Rpb24gaGVyZT8NClNob3VsZG4ndCBpbmxpbmUgZnVuY3Rpb24gZ2l2ZSB1cyBhIGJpdCBtb3Jl
IHR5cGUgc2FmZXR5LCBvciBhcmUgDQpjb21waWxlcnMgc21hcnQgZW5vdWdoIG5vd2FkYXlzPw0K

