Return-Path: <linux-btrfs+bounces-2274-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7C384F21A
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 10:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1745F2892FC
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 09:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C26664CF;
	Fri,  9 Feb 2024 09:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V5nyGKUi";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="csTHda4M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC673664BC
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707470197; cv=fail; b=mrJnCzQDCh9WYv3ldE9xuJNTO/cs0gckauU9gKNoxeUxoyhshY8q/t3uuD4tQKCgsFs4NUVuYDuqYsofxSK/1FzGKbRoIeqTYN9wBBB6xwFnhYPREqzqXn9rhYWkjLDWCw2VBJFnJDw2IC1gTNHOl8q466PEKpliNIioV2vgE+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707470197; c=relaxed/simple;
	bh=f892AGXIK5gJRMjFLeGioLlQr7gzCG9lkp6X+4R+III=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M5rDo2nd/0PbM3DuVIlHtJf8KqyYFQ5NxjHmKFxQP0EO5psoGC8qojYQtNuuiUUiyWywdabWSQqTO/+eT2gxg8KymSuLJ70YHMwGfEeNkKSJLD8K7r33+VH0OOw0oLv1srBq1L7A0XSWnHw1lKktdYpt/2HDUBfvWDQ7nBtUTrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=V5nyGKUi; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=csTHda4M; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707470195; x=1739006195;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f892AGXIK5gJRMjFLeGioLlQr7gzCG9lkp6X+4R+III=;
  b=V5nyGKUi70dXdsV1z5nJ4zg024PTo8jQpusydLcG9FamAID7VVAeCvbb
   qndV9OIKo7qwNmRw614MAweFeu7VkdLiMw9gIb/mrFC8Wa8izu0Za8L0I
   NNxDPPXIhLMnRg+vKjXfkW2aSIORy4Uw6NNP4joWvoK6FgmTey4BVU5mH
   5rS+868KzvItziFTlaJ241y4JCyqFFedPcChQUQTnRvvlAnue1ezH+8dI
   TAntR50NjwjYy6sXdNqNvAqTidBHPpJrbPPQVJD9sbQ9NQiOzhCTYnflj
   pVnCemCAvCyifpvU6ZL0L7snusmon1SenJj4DW+lVfUv0nrBFkyMMs+IQ
   g==;
X-CSE-ConnectionGUID: 6erKSoC+RiKlQ3AjZblGVg==
X-CSE-MsgGUID: yzpwyGnmRz+Pl5p2LPN1Qw==
X-IronPort-AV: E=Sophos;i="6.05,256,1701100800"; 
   d="scan'208";a="9130942"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2024 17:16:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQ763ixrCiH59XzDcX0mkjnplt3lReRbvqOj8ad/FnpVi7abOSm8fE7Z+UVA8xteJLWPwaGgSQoz0YyLlgalvUJL3SHzm6/Bm87fwDho9xDFPMFNy+8vC47hi8hbu2aSEJms9097oWruomwb0cC0N05rxvYGsLP3mpFcBBAk3j2mZjwymYZGBhtWV1WnUA8PUpYDuyjl4Na/Hlacoju3sOp/KX/nl2uVwQT9qorFokRDFkAD8CXG4xk06tk3v1D3Z7LoPXl/mdXQjh0ydN4tJVB7sya3DxIv3mYyxbP5SetterbHcA00PmPLIX3uKMKXmplsA71gESgoLRg3VoNNKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f892AGXIK5gJRMjFLeGioLlQr7gzCG9lkp6X+4R+III=;
 b=gW/GL4bX7IrxRT3yn5FZ9SdRvv498lj0YaTP9kjIJgcFHBB68hYKzwOCCWtjSneS/jUecaMQ+Rr3VmygzuORZ2X8gzLapspbwc6Pz6+POKn2zfWqxwUiMbI5v7uzRVNNmKmolVb2M1nCpl/bb4ov/NrBW3L9xweXd1XadvR+EGpduN5fvdAqkiFbOtsAEuAQVvysXkN/H2BPBBAVsMlp7rZ85eJ6SYdGSPB/mPVdc5NL9aetTDHh/Djzxli9iPyf8abEAyEmORhfef3xBs+Y5q4t8lxlpwf5WPB4HAuJKR6IvKd8IN3xhx2aD/U/NsmDQFmb8WPxFEyW8NE6MRNFlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f892AGXIK5gJRMjFLeGioLlQr7gzCG9lkp6X+4R+III=;
 b=csTHda4Ma4qppxrt33J0ayh07EigOsrrCaJUyAEOVhmO/cnQHBAd8BFWmfwVBgrxEdkbPbzLeQ4PVn6RE4iK6mwLymEeBchUcN/tl1f+PQQCGfx4lre4VZgw5tgD+XiIA9Utc0ceUy9cHCWcwWDFtjnQsXzWwJSzkhqO0j/nFRg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB8503.namprd04.prod.outlook.com (2603:10b6:510:2a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37; Fri, 9 Feb
 2024 09:16:31 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c%7]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 09:16:31 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: =?utf-8?B?6Z+p5LqO5oOf?= <hrx@bupt.moe>, Qu Wenruo
	<quwenruo.btrfs@gmx.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [btrfs] RAID1 volume on zoned device oops when sync.
Thread-Topic: [btrfs] RAID1 volume on zoned device oops when sync.
Thread-Index:
 AQHaVbCKj/f1FqvKZ0SR7X1wPPWj1bD2+NkAgAFwV4CAAMh/gIAAvbwAgAFL4wCAABdUAIAAE6IAgAUG+gCAAUgDAIAADC2AgAABoACAAALmAA==
Date: Fri, 9 Feb 2024 09:16:30 +0000
Message-ID: <a16fd773-51ec-4c9a-b89d-5b4dcf9d1f44@wdc.com>
References: <1ACD2E3643008A17+da260584-2c7f-432a-9e22-9d390aae84cc@bupt.moe>
 <20240202121948.GA31555@twin.jikos.cz>
 <31227849DBCDBD08+64f08a94-b288-4797-b2a1-be06223c25d9@bupt.moe>
 <20240203221545.GB355@twin.jikos.cz>
 <C4754294EA02D5C7+15158e38-2647-4af8-beca-b09216be42b5@bupt.moe>
 <ae491a34-8879-4791-8a51-4c6f20838deb@gmx.com>
 <6F6264A5C0D133BB+074eb3c4-737b-410d-8d69-23ce2b92d5bc@bupt.moe>
 <66540683-cf08-4e4c-a8be-1c68ac4ea599@gmx.com>
 <cf12dca9-e38e-4ec7-b4f2-70e8a9879f53@wdc.com>
 <1573ACF30347C754+463b9523-d8b9-48ba-806f-c7eb89c55827@bupt.moe>
 <7c852b20-dcc9-4dcf-9c36-5c33692559e6@wdc.com>
 <d3b8ff0b-0f76-40c3-aa01-f5a9bc405512@wdc.com>
In-Reply-To: <d3b8ff0b-0f76-40c3-aa01-f5a9bc405512@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB8503:EE_
x-ms-office365-filtering-correlation-id: c6f75448-9506-4d4e-c9b8-08dc294fcdaf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MMH5Aa0mIjZGiJ1tw/ELBk67hJdugfWaWYMsHUdey+c+gj10bfN6xMu17MvuzBaRdfo4UiJeOpIwQ4ZgELUPZRB6ziX7r/4dZtwFkLgISN4EM6rVDyVk4JrZOhb9R43FnPBV3wpS+RSHV7CGJj9qFo+8CQD4vAeGj8KB/t1RgQ7NEDe+78V0MKVGQvF13eAeZdQc2KHd8leEou/3FrVsBagk4JLWf5HvSx7leqL2guYqZRwfN+TbsbjfbjpZf6OAykw9ALOZ6UnfdffcmSjqIvr27zBG+n2CKsc12TDvjPanm4QLsH9/K9NL4Fq9o6fzr2PM52BBN1vXqVJyA/RZZx+jk9FuimBsIPzn8NiV9FNkO+gd1KMut/F4l2KkNQ3dT90HSw9v8U+QJqVxp5o5iE3ZjYOMYSbmUCV+zTltFWWMng+tmUsBBnhZeIhSIg1PiMPVmAKAUcdt5d7phDEolUWiYCBlp72jZQ+OZtFcULjE11A9I8C45gjpStt/5QoE3G/086vNuidgaYT9MCFeiK4aVjjVDrCRQ31wrK/ZAdX2HMB1r30GIyXdnSxK0dayXTanaPMp+IQoXkF2JefFq3PB1aTIGEEjnQt5MtcWQwg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(366004)(396003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(558084003)(4326008)(41300700001)(53546011)(966005)(64756008)(6486002)(36756003)(76116006)(66946007)(110136005)(66476007)(66446008)(6512007)(478600001)(6506007)(82960400001)(316002)(71200400001)(31696002)(8676002)(8936002)(38070700009)(38100700002)(86362001)(2616005)(122000001)(83380400001)(66556008)(5660300002)(2906002)(31686004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R05MMEJyZS9zUDB1ODhaaXFHczg2YWRHVXdBTjBNckU3YWpaMmszZHBnVGc2?=
 =?utf-8?B?N09uYVdKTjRqWlhsZlBBR0RJVmxybHk1YzJFOGI0THYwbEVsY0gySXIvSXZu?=
 =?utf-8?B?bEdsQTY2cG9zb2Y0Ris5OG95clQ2dG5UYks1SHhLbkZhRnZ6SmJVdGdaT2tD?=
 =?utf-8?B?WGFjNm00MEJqNXBRY3I5R3VnWUtnZE9WT3Q4ckIvTkV3QzgraGFwVlMxaWp3?=
 =?utf-8?B?emJJMUF2c1NqTnBzSWpJeHhrbmV6TVdSSCtEcVJ0eWVwTlJRVlBVdU9ZYml1?=
 =?utf-8?B?RHJCSGw3b3RUdndhZHhCR3lIcjZ0YUE2U3Z3NTZucDRYMHZFOGFWR1picERF?=
 =?utf-8?B?MFkvMTNGTXdMNjFZRE93Qk5SeVI1WHRpN3JDbDd5VGxkQTFObW1iWVBFOHI2?=
 =?utf-8?B?YlVkK3NxWmxnVUF3ZVVPNXA1ejdvVEtROWMwdlQ1emtjcTdabG5sQURDZGRz?=
 =?utf-8?B?L1ptaWkzZGtYYnlkS3ZLYngvOGVFbXBZOWg5Tk5ZdUtQOFl6Q3M4dkQyUklZ?=
 =?utf-8?B?VHBLaU1KTi9Nb0ZUU1h5K0RpbURlMGNFbGNTajh6d0o5a1JhQ0diajlndTY0?=
 =?utf-8?B?QStiRXFsYTgxTlJScW5jR3M4K09TVjRUSUNEUUpUUGZ0a3kveHJPZnNxb3cx?=
 =?utf-8?B?ZTNDUGovOTRac1ZmNWZ5V1ROQkloTkloS3F5RGRjc2VKcjNXWWJqUEZkU3ps?=
 =?utf-8?B?QzVqUENIQXVsMmYwa2FYdm1JTWhnMWtsYmF5b3U4aGdSTFpFdTFFbzJrK0FG?=
 =?utf-8?B?aXRGN2dQNTZyVzJVZzZTMUVLSzhGV1lHQUl3M2VzdjQxMVo4eFY3NjJka1FU?=
 =?utf-8?B?L25Ka3JXTXNtNGRPT2QzTGthN0NpclkwbWdZdVdOMWdldlpNbmdnS3h0M3kx?=
 =?utf-8?B?NGoyZGVzLzZ5b1VBWWhOV3psbkExSHExaFFzTVBpYml3a0tjTEh5UmlWbi9x?=
 =?utf-8?B?THJWdDluVUI1eW9SSXg3U2dQcTZSVHR3UC9Fazl4N3MrdXFCb0pEYXd1Y3gw?=
 =?utf-8?B?ZUs4VjVUalN0RUtwQ0dacm8xbFo3ZFBoRG9XWm5ZcWs4STNJTkpBRk5HYm8y?=
 =?utf-8?B?SlRpZHVkZlBKZzBBRUJMVWFhQy9jcTlpR3ZEWEFmdjRsRzBzdG5Jak9EZmZz?=
 =?utf-8?B?SGF0K1U0Vlp0R0xhUS9ibG1ucXhqMVFGd0E5cmZZbjNONkRYZWlIaG9MeVJ6?=
 =?utf-8?B?Mzkyd2pTWGxtb0JQOVhLeFVJV2dzS3lENy9xcDIzMXpwSlBoeDVOS2NvQUtt?=
 =?utf-8?B?UVM0OVlyVUpFTU5yYjVHNVRvMmVFVlRVMkxHdkV1K3lqaEtJdHNPZlNBVHFl?=
 =?utf-8?B?R3kzdHNKdDh1WnljTmczQ1R2VEp4ajZuYXZiekxyTDBvcUw1dUxteEI2ckJr?=
 =?utf-8?B?d3dRT2FLRVJFZEFBWGlqNWthdk1haGI1ZDVGd2l5SXJmdStUb0UreVM5QlNC?=
 =?utf-8?B?K2FlaE5Ed09lQVRNdWlwbEliaDBXeEJTV0V3ckhKUm03OFpIZm4wRTZEVTFV?=
 =?utf-8?B?L1Z4YldXTzhPa0xvTDRHa096MktrQTRjZ1ZTdWtPSGg0ZEpBNzJHQXMxWFhS?=
 =?utf-8?B?d1dtdjhLeXdZajZ4SXBKV3QweHhoS2RVMGJsdlk4dlI3THg3ZU8rUU0zSkxm?=
 =?utf-8?B?ZnA2L2RLYk1uOU44WTdUVVUwdTJMajQ4cVdQMm1wK1JJWllvS0NudzdycjBI?=
 =?utf-8?B?MEFQZUVqVDBwUkJNa3FtbUl3eWtnT3ZvT3BHbkpKWjgwMHQzbmJET1ZDbE0w?=
 =?utf-8?B?b3dpZmM3SkI4RU1LUzExbm1jRVRvcDRWQTJCcHlzdDcvSGZwdDRkbjdtMXFT?=
 =?utf-8?B?aHM3aTVvMzFjM0pIK3llS2lTQ2ZaOEMrU1dUczFqOGlLbk9OY1QzcEFTTHlx?=
 =?utf-8?B?bk0xOG5CaDBZMWZzTnQ1aUlaYmNwdkZoVllhc1FESXAwbW00UzAraHJTS1V0?=
 =?utf-8?B?YkVUYmV3Q3lqRUNha0dkNVhPM3Jlano2ckFEemlWY1poclhGcitkWEZnMDNy?=
 =?utf-8?B?cnBzRlNyak1XRnkwa1BDbkNIcTZkQU1neGFJTjUyTVRQb1F2K3g0YUhMVjlF?=
 =?utf-8?B?STFob3ArNkdwTlpIYndvWG9PTmFIYUJZWFJaTVZzWlVma3Z6UEltSnlZUXV3?=
 =?utf-8?B?eEE4bW1Vdk9SWXNUZ24wZEJwdnJ2V1VNcmU4NDhkeDVxSTNIeHBGTUxEMmd4?=
 =?utf-8?B?UjY3Q01ka0JFU0h0M3F0UU8yWFJrSHNiMTB6VkxVUDE2WmVoUFJiWFNNcXc1?=
 =?utf-8?B?T0I2MTdleVMwNXFJYXh6VFJHZmNBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72F0126AEC692F429E5B2C03B00B86FE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	naXTBhHlfA/rDAuJsIXGkNWIUQ3nof/m93gXzIenaBQRhJnRE1GjyLg1LcezlHbTy4DsEwj5pU09dovknadvOSDNb7uzBPkjOkjhPTxSh9V4Fn2OTnJtV0SKTHosC6c85ohrvzbE8kZ6Nn74tYYWZDXZv+Tr7TRekfcKV5BvfvozG4Jt7eBXIm0smvdB7fL9hZSYRUy3xy0vT/WNId3oCQYEX8sXMuO1s+dBHfFMWYFPLifANsJ9bL9sHaG+7RLCP4BLlYiEihHGhCoGjqZJXvR4DGntJNAKCP7i267X6tbcEYBuPSH4wNqLFUSKuOVM2k7HUfQ+qBlLN43grLaeSQU5HXtzRT6xTslq2GrsPxZKZmy90LFEMn3lo2tuRw4GmWI/TxBCRH84NnIkL3Rafl6oe5soj073fjYD3vvbBCzlskd2aEyljR/KRNXmnJS8vm3wu798guPrVBwHfW2hap3Vs+MJ88vYoEfF6COpTE5T+lr7b+AmVrgzMoigONhRv0gVmG3X77dZN7/ltSC66r9vHHe4iwMTqlVERNkSvYeJiJjtf5zKFk3u85mLU8CVYY9yFVnM6Rtdk3JqWTS9BPU4Dru3EzatAvRIS12S9AUW7nLJgx27xJGzU25INhI3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f75448-9506-4d4e-c9b8-08dc294fcdaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 09:16:30.9170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dA+zeG/mLGwh/ioR2baihpaMLY17oOcDCjdsMJI7KPbzQfHppf6UYsjLm96TAaztSdi3yqBsfLpTbq0o/gJzycuq4WV4hF/E1/LSDvCiwt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8503

T24gMDkuMDIuMjQgMTA6MDYsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gDQo+IA0KPiBP
aCBJIHRoaW5rIEkgc2VlIHRoZSBwcm9ibGVtIG5vdywgY2FuIHlvdSB0cnkgdGhlIGZvbGxvd2lu
ZyBwYXRjaDoNCj4gaHR0cHM6Ly90ZXJtYmluLmNvbS9mc3MwDQo+IA0KDQpPSywgc2hvdWxkJ3Zl
IHRlc3RlZCBiZWZvcmUuIEknbGwgc2VuZCBhbmQgdXBkYXRlZCBwYXRjaCBzb29uLg0K

