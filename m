Return-Path: <linux-btrfs+bounces-1958-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F19843B32
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 10:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338831F223FC
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 09:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA119679E1;
	Wed, 31 Jan 2024 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="B9H0ZvBh";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nCFg0+ik"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD37666B25
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706693650; cv=fail; b=UYin1lZKhEOt7qNclJGfaZZkMf4pvOOk616I+ATbIsFsd95c4DNZXu7wZCv2pa+wF4vDDVgfbKi4B9stQ5cQqF4s++tP3uMMYsO1ZXSZkaPXfhP9/sf8O9kS6dy+mwS0nPREZVJPstFYiD11/L0c6L8XLNFRi2nvB7Smh4kBdY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706693650; c=relaxed/simple;
	bh=SywXHBGKxkNC5ovF0PpWhsMcW1ms/4/eRDnitqei8DA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IEabySd6J2CVLguFX7OZAo0kxWexiLz8UObgq2UzZf+yBqqXejBOhbV8+on+7EG4/JuTDrLLlJDBdrh9KtXn4TrtM/NAxLfajpm3agwzY0TsfeLv5cTGrbzOrKv6jrET7h1I5aNLuQj0ffOzI7zUKldfyEuRlisQiYc8dkkdtcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=B9H0ZvBh; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=nCFg0+ik; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706693648; x=1738229648;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SywXHBGKxkNC5ovF0PpWhsMcW1ms/4/eRDnitqei8DA=;
  b=B9H0ZvBhFJHZgjxFUkPfdeuf29NWv5tYQxxKKnmJGrYvJ9lASTKddQmI
   wa9utCyY+55IO+HK2KKSbfoXeenijgnVd8sZO5GToQX9cV+6yWWfEtEGp
   c3XCbfq0Lwm2jGCC4BHIkD8/f4PR4vVm2RcYmlcJN3XEPHi8hT1Bh+m5s
   mAi63HVoeCMTK/GjA97dkjyAZnRPyDx+iml6k9LElcoej1OYgwojrPqUU
   k/C6wbmk57Mi1X+an977cjeQ0Q55kphPs9Gg+20NwB1k98Z2UT4C8UDyf
   n8M3q7MmHTVKYCpUUg4zmrObK/TB82AuYcy8ATrc0y2MvuzOLoXNGJwGR
   w==;
X-CSE-ConnectionGUID: +OfpFRqkSp2wk57uBI5VLw==
X-CSE-MsgGUID: ie0TlyIgQjOSDBFaI4qTgQ==
X-IronPort-AV: E=Sophos;i="6.05,231,1701100800"; 
   d="scan'208";a="8687558"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2024 17:34:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/2vMMtq0y68IndcodSZHnLjg6c/4H0MFdXSNfD5zeK4R0jq4XmjkiRNnSaJ2KA2iIhRmz9pTkElhlPnrF8nzumK0pM0jfQYkz2q8+EvxFDlug6hHE9k90nhff6VgA2ZNK1G2C/nDHQZEeZvEYzMs2Qs4zkeEGTr+inDSnG+1ifQ55uY4IwW346evPd6DoqbiNLLlDBnfmTkENiluXJfTuA7oO+UK3Au6piNOM60v+J5Qaud2OPC9lxBcaYWfnFBrmYzX3E0zF5HbU2R61+1TKdsiBOmWi5ekAlsj13MnO/OA24n9aegZxsG/CgyABTVgEKjvI4pYvOEEBDYx271Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SywXHBGKxkNC5ovF0PpWhsMcW1ms/4/eRDnitqei8DA=;
 b=dpwFxL3a5X13z783vcZoX22lAt/rVOOb0c0DWasX6qSzheWoiqBvgRHok6WdhmXPB7tJBduJJ33OP6bowbwsb8goKfLCz0v6fcZWUrs0qw3UIrWM2VMS6jklz1AH0ci6HJqY45TOBQJtnOFNOBnyvSEkGDWBj8aEtit5TtmccSh/j7T3KtcwdzcgHRXg1Vo4/WMcLSeH+UTfHEZxdr3PX0JPRkP+PFglOzTm9qGi53YBYoU7jYDxNyY2Qn62OMuWnoxch93HP2jxrzEyykEXHf8ClnTWekqFkcHvJjEd+K7Bv/lthofnDPXXCoI+TO+AdA8W3QRrmbshGiO0LT5mKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SywXHBGKxkNC5ovF0PpWhsMcW1ms/4/eRDnitqei8DA=;
 b=nCFg0+ikvvkMfYzvqSDoJWdjA/sGSol2t5O9wkz8WmKCURyOd3z86cB0jup99ekIfsGhSEuMCMWn4mUoP8CgZvVJc5bEPdXIh9f+TDC9NgPCOKPRJOA+I5i3ukRqiqVeXzOPpbiu9P09rYOlmupQE/b86Elgg98MZqIRBw2Z0YA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6694.namprd04.prod.outlook.com (2603:10b6:610:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 09:33:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c%6]) with mapi id 15.20.7228.036; Wed, 31 Jan 2024
 09:33:58 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>
CC: David Sterba <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/5] btrfs: add helpers to get inode from page/folio
 pointers
Thread-Topic: [PATCH 2/5] btrfs: add helpers to get inode from page/folio
 pointers
Thread-Index: AQHaUuG57pjtgwND0ESmOAy2ke5/wLDyPQwAgACCYACAAOwLAA==
Date: Wed, 31 Jan 2024 09:33:58 +0000
Message-ID: <ab1e02ee-b1ad-44df-94af-7b788e6a63fa@wdc.com>
References: <cover.1706553080.git.dsterba@suse.com>
 <86448b99cc16046569c38cdef83c41afcd8047ed.1706553080.git.dsterba@suse.com>
 <f5b412f0-9c06-4c3a-af47-d3077b79c2f6@wdc.com>
 <20240130192908.GC31555@twin.jikos.cz>
In-Reply-To: <20240130192908.GC31555@twin.jikos.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6694:EE_
x-ms-office365-filtering-correlation-id: 872de9f0-6600-4488-bb10-08dc223fc06f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 KA+NLTb/ZbkdG6AJx7NMcMDbFXZUufCw60Fq21xvsSzwgbo1RhM9UY+VH+OyqWroTVNCdBK9OJdzYAZ5qeblFlMHMQS31vPK+WKiQokigSrmYLZqnhuq5T3EMfSSMcMz/eTqGOxLqLxrtOCARbF4ytYyFrOzaRZtZu+86y7FosUjUkchgHV2WBSNoGFe3DFQAozb2SxwBrVnWupu/LHwWFm584H7CsyO24vjow4jLWLbbQ9MAtg/AFy+1H92m3UVbeqwBYhU7F+AFOWaMQC2+LvtzAsYKqcmerhg3cMsOl3NNxl6rNf07ERlQpT4kFnGfGVkDSjIrnAoABBecxsyisRrT9wUnZpPe48sM7jHZBDJtbpKAfNZT2KUplNTFnaDFDbVRoMlTtROrjGLqX2hPimgdx4c0f1ESTXQ5JUaXAcFx4zRAaSxnRoB7AQGndRoykocUsbZSq2lu1SdCkDRzacgY8WTGzi97TIQj6dRD5keZ7Og8OGLBFNFgpkKa0A1DQXHJN7byUg1iuTo3ZvIAh8O2DfN5rN80vDLoAQpcsHp0OXegWGIMAUcnsS+H2YwOg7OlsXQZlLF499ZFYYvaJhp4gaT1C96fKvQD2VYo7Yjk3SzSd8B2j6sWFvoAZwDJUktjbZvdpTYHN+TFGbF00XEusIFY7iSRfc4AE/M4k1H45wlv8KuiJo4QRroq9/d
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(39860400002)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31696002)(71200400001)(64756008)(54906003)(316002)(6916009)(86362001)(66446008)(66476007)(66556008)(91956017)(76116006)(66946007)(38100700002)(122000001)(82960400001)(8936002)(4326008)(8676002)(31686004)(478600001)(2616005)(6512007)(26005)(6506007)(53546011)(5660300002)(6486002)(83380400001)(36756003)(2906002)(38070700009)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MEl0NHl1bnpnbVRIS0lzc0lmcXVJNW5RNWJ0VGJPaHBWSktVQVNlbENPdVJF?=
 =?utf-8?B?SEVTRVAyekJvUUZ2TUpzYmgvK1g1bnRpeEhScE0xSVhsTHd0THhwRjVVZFEx?=
 =?utf-8?B?YnFLQnpCN0JFZFhhMUl4OUR1MXk4b1pGOTNLdnNRUExJZDZiMU8zaDhlbXhK?=
 =?utf-8?B?WlluN3JwYlZ5WWh0ME91OW5keEwvNW9VWndITC9MdXJUVFhlclMwb0lLbTBC?=
 =?utf-8?B?UlJUOXk4REFMaVFPUnJyVEc0QkV6d1BIaWg2YVYyWFU1SXdKbzFJcWJQc2hv?=
 =?utf-8?B?S3NQKzZqbFBTd0RZYVJQaEVUOGsvUVdoYzJiMGx0bmE4Sy85MnAxU2x0QmRO?=
 =?utf-8?B?YWpaVTVRdHNRenhxTVI3MklOczVwQ1lpYk1ncTNTbnE2MTBQMjE2dEpzeTlz?=
 =?utf-8?B?UUwwUHlJaGxDVFR3bHIwRWhNb0xNNWlja2FSZUIzRmRXWU9pZ1FwZTBuTVJa?=
 =?utf-8?B?YUlwSjdYQSs2SWQrNy8zVTIrU1FKV25iVXhRZTJvR1BsTEpDTUYyM2U2bG9R?=
 =?utf-8?B?U0pvZEowaEpzd0JhS2dETGdxTlZGSXNVOXlMdmZTbGpXS0Fob0ZubDJkaGVL?=
 =?utf-8?B?dnVQMi9rTEJVZDA0R3EyWDR2YWVKbVh5eXpETGJTMmtNTzBrRlVuM2xaMTZp?=
 =?utf-8?B?bEk3V21kWXFtT2dnNUxOcjJadklMVytqL1pqYzBNVG9KV3hhaXlIM0hzTnRP?=
 =?utf-8?B?RURqMVQvYi9nTTFabjMybUNtZS9PeEkvblB5MEVNdTg0RTErZ3dZMkZDTWp6?=
 =?utf-8?B?bmp3ZTE0ZE5VOS9ZbzV6OHMvQ0Uwc0grdHV3d3JTY1hzcFQ1OVNaZ1NkOW1R?=
 =?utf-8?B?di90WGVCMVRZaTlNME5oaThqRisvSHZZd0xBTzVDYkU0MVdNU2prbXVFeWZO?=
 =?utf-8?B?Qytzcnd4aWE1d0dINHlpM0p0alRpZll5aG1aMENCZTkydWJDeXpud1VUUUN2?=
 =?utf-8?B?VStxYWplS0dJWHd6RmlZRktTWWJuSTZSMFRXdGxEemYycG01dUhrcWhoQlVM?=
 =?utf-8?B?L2crSXhhMTRBL21PaVRDUmdLeG1HK3BoT2gvWTJHVCsySjh3ajFTZEZ1Z1FX?=
 =?utf-8?B?c2JuSm5mS1JUcURyd1ZFNXN6R0w0T250RWdiVmswWVBNQi9IWjZVT0JVeUJq?=
 =?utf-8?B?bGp2Rm1KQi9La0dzb0o3cEh6Z2JGWHpvb2FzQlhQdkpHMVJidWpjZ3B1amZ6?=
 =?utf-8?B?R3JveCtYcVc1WFNZNFBoVHZFYWRtYVdlWStkTEdWQmt6T1RJOVp6d0xLeEg3?=
 =?utf-8?B?QmpCK0RydlUxZ2dkQ2J5djVYUittSGtONHdPeVJlT3pzeHJRemFjbTJ2S3hx?=
 =?utf-8?B?WEtZV3BtRnIxRVR5V1FOcU4yVjEwb1hHNHpicmNHOGVDTnpXWFl4MUl6T0tm?=
 =?utf-8?B?R01WUmJnczR3TXB2ZU54TG1UajBoR2czN3MrK2hLSHZGMnZkWTBSOHk0UVBj?=
 =?utf-8?B?enVQcUVSb2tSYUp2U2tSYkNWYlkyd0JSbDN5V1dTYi9iTFBuNWV0OWFFYUtr?=
 =?utf-8?B?VnBsclJwdnlDMkhxcGtlR0hnUGVKMFFmbTRualhtdmZPb3Z4VlFHYmNKUWNi?=
 =?utf-8?B?N2RsNmJNQnlzMzh5WE1Nam51YjV1VXgwZ3NldUhlVVE0NzlqT0sydlhqNmhM?=
 =?utf-8?B?YVhsN1NJLzNjT0RCRmNvenAxNkR5dzJWZVpzNTZydWwySnJpWldoeHdJRlBt?=
 =?utf-8?B?MjlzeWtLQ0swZFEvRkF2aDhFRndReHJSTW04eU5CQXJyNGRySFZPRitYV2Rm?=
 =?utf-8?B?YStadHFGL0tubU01ZlFEWWRCcDdlbG44aDVXYnVHYW12UUhEY2tYek1yTlNz?=
 =?utf-8?B?N3dNUmtxNm5rV0RYK2JNZGVZZ1UvMnZuRVJzOU44VzE3VjV1OWY4NFZRc3ZR?=
 =?utf-8?B?NlZtR3QyK243Y2ZPVzQrYlQ0cHE3ZmNPYVA4S2krL2drb0RYNG4vZGpqVjc5?=
 =?utf-8?B?VDFYbWdrMVoycmxSdTQxM1l1MTdjRnVTZzd3VW83TDVycU5GRnhPMzZCUG14?=
 =?utf-8?B?LzZZM0dxL1BJQlpSdmNOdGFHUk1uMWttOHNMTHMwT1VhYzIrTDJOdFBFakFu?=
 =?utf-8?B?UU8ybHlNMmQ4NWRIV2RKdEFxS0g0c0d2QlhSYmY2aVpvWEdmWnYyOEIwMWRP?=
 =?utf-8?B?WERiaVVXWVpwZEJJdkZaWTlxUU00MXpCOGxVRkd2SE5yTk11bUgyNVVVWTZy?=
 =?utf-8?B?VUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <612759032B623B4FA1C39057A21A3DF7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dmLsf7f0f95RQmIW76pV89mjNOYNxrlz/3F5mjA3E3pnlSDKmuFNWEUB7RLROeM2s3ku+UU5vBS0k721vcOFdCkm5TUDrvOexZ2k3nrQ57b8pSB0BJtqRij/FNeHYqXUMYPt07MwCxlE0KVGAjiaUgWcBW5xtTF3peiAAkRF66yb+qPYc+G1Un+DpdElIXcRSr3nncXjjxap/V4itgHFA5ZBTbDLvgb3p/uPCJRc/EPy82mLadrE76wQaQpqMjExpka9hBixihhL36V4NWj7MV5sMW94a6AKV2xugA/CahA49Eb0+mYrjfd6wVzfPm3z9Ll+H7IDjNjIUtDo2ewQ6t7e70fqhH445G8HRmbvZ/dhqSahpNt2DtZ2YeGiTqFxb3Co65ZwKSHtfRlegooId9EG1M6MyX7qeF0HoJwAoipMXKFDrHaI4Dt21k4N2Iqwk+pX4PCsSno/N0WSMSaWpjzkK/1sFKBQczaMNgpaojm7t7qSYenmHlXfEjD4UvKd1b5/RgX25kG+4iMekkSbZ/oYLZjUTzlZi+no1IUKA4TifoHqlTZ6go+Y8NNfhVj8RnqgHVR+K+NdDCrlnjAcUO5gBJpOsy0NVotQvU3QFBIQheCGOrrIxu4v8OLgdxQn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 872de9f0-6600-4488-bb10-08dc223fc06f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 09:33:58.6118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nUnTYQSkel9BdQju7V7YI0qQaOgOS/X3wUV6JHvCB9uDe38e2ATkbeRcx10e4aNtdi6sCGKachnRvgmcb7KGXhQdYgrK8tek9J/BWswIBoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6694

T24gMzAuMDEuMjQgMjA6MjksIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gT24gVHVlLCBKYW4gMzAs
IDIwMjQgYXQgMTE6NDI6MzBBTSArMDAwMCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4g
T24gMjkuMDEuMjQgMTk6MzMsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4+PiBkaWZmIC0tZ2l0IGEv
ZnMvYnRyZnMvbWlzYy5oIGIvZnMvYnRyZnMvbWlzYy5oDQo+Pj4gaW5kZXggNDBmMmQ5ZjFhMTdh
Li44YmUwOTIzNGM1NzUgMTAwNjQ0DQo+Pj4gLS0tIGEvZnMvYnRyZnMvbWlzYy5oDQo+Pj4gKysr
IGIvZnMvYnRyZnMvbWlzYy5oDQo+Pj4gQEAgLTgsNiArOCw5IEBADQo+Pj4gICAgI2luY2x1ZGUg
PGxpbnV4L21hdGg2NC5oPg0KPj4+ICAgICNpbmNsdWRlIDxsaW51eC9yYnRyZWUuaD4NCj4+PiAg
ICANCj4+PiArI2RlZmluZSBwYWdlX3RvX2lub2RlKHBhZ2UpCUJUUkZTX0koKHBhZ2UpLT5tYXBw
aW5nLT5ob3N0KQ0KPj4+ICsjZGVmaW5lIGZvbGlvX3RvX2lub2RlKGZvbGlvKQlCVFJGU19JKChm
b2xpbyktPm1hcHBpbmctPmhvc3QpDQo+Pj4gKw0KPj4NCj4+IFdoeSBhcmUgeW91IHVzaW5nIGEg
bWFjcm8gaW5zdGVhZCBvZiBhbiBpbmxpbmUgZnVuY3Rpb24gaGVyZT8NCj4gDQo+IEFzIHNhaWQg
aW4gdGhlIGNoYW5nZWxvZyBzbyB3ZSBkb24ndCBoYXZlIHRvIGluY2x1ZGUgaGVhZGVycyB3aXRo
IGZ1bGwNCj4gZGVmaW5pdGlvbnMgb2YgcGFnZSwgZm9saW8sIGZzX2luZm8sIC4uLg0KPiANCj4+
IFNob3VsZG4ndCBpbmxpbmUgZnVuY3Rpb24gZ2l2ZSB1cyBhIGJpdCBtb3JlIHR5cGUgc2FmZXR5
LCBvciBhcmUNCj4+IGNvbXBpbGVycyBzbWFydCBlbm91Z2ggbm93YWRheXM/DQo+IA0KPiBZZXMg
dHlwZSBzYWZldHkgd291bGQgYmUgZ29vZCBidXQgdGhlbiBpdCBjYW4ndCBiZSBhbiBpbmxpbmUg
d2l0aG91dA0KPiBibG9hdGluZyBtaXNjLmggKGFuZCB0aGUgbWFraW5nIGluY2x1ZGUgY3ljbGVz
KS4NCg0KSSBwZXJzb25hbGx5IHdvdWxkJ3ZlIHB1dCB0aGVtIGludG8gZnMuaCBhbnl3YXlzLg0K
DQo+IA0KPiBJIGNvdWxkIGRvIGEgdHlwZSBjaGVjayBpbiB0aGUgbWFjcm8gdXNpbmcgX0dlbmVy
aWMuDQo+IA0KDQo=

