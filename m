Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE1E7B4F13
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Oct 2023 11:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbjJBJcz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Oct 2023 05:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbjJBJcy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Oct 2023 05:32:54 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06B091;
        Mon,  2 Oct 2023 02:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696239171; x=1727775171;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RbG4BjMwwRMceJiUdPZ+1plE0FCqJxL+EWp38ylwBJo=;
  b=qnEtkVeD0j99qcV0RAzi64cG3iLnsQGWm0rFGoVBpzn6jBdD2gp3mtZv
   z/J1Bz5tTg3rv/KE/UW8MPNFXpszwZrf0/GExBetcfHwrS9rEeOn95Qyk
   2Ja3AbLjV98U6CTh3CbPHKua3cLNDyqrsHe6rTVSS4bexDbG6EOEpM8n6
   8Tn6mvZt3LWOYvOxK7MHVJblyPWLk0yXxWzsMgIQ+dyks2M2O/YiKkryU
   y75xB8WVLyu1UuIisNLXRxkIm+HwQcM3l1g5Y810y/wt3WQ/WNJJttloC
   hNYbOVe8c1luETMiNv84ok5HCFta6rZlFuc/cW7OQUGUBknkZ0Q+Coh5f
   w==;
X-CSE-ConnectionGUID: 1PTpijoESxC4S5fu4s21cg==
X-CSE-MsgGUID: j5cdi9zaS8KgJvloVbwELw==
X-IronPort-AV: E=Sophos;i="6.03,194,1694707200"; 
   d="scan'208";a="350837242"
Received: from mail-bn8nam04lp2048.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.48])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2023 17:32:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+iYwN0XNm45TL/aMar3bkBxhemBW+O9+PTPWxV09/u0yYA5EYNE9ZzeOBN5htZ641aF1XdLwcO3m1p/wFRxxvOPqX2naQ5vgko30tY0ARnPMa6ezUuD1CfJjdPXxyMf98/Esuof+cpsLpOy+8sPfTEJQa+KSlbtVS8y9vPVJpYzFN+NMZ5W6jKWfdOQXBUf9qqmrvtrxRLWZ4mG0sDSEK+fNZFt8LQfNDfVAcDL4bIF9CwJVCEZNJ3+oIejMZEYDWvnIFnvVw3NTo2vc8xybs8+atc0qgUzhtVb17qUJbTPQzXXlyCOo/zT6i4G15bzyPmIDc2y+poQptkIkAPWKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbG4BjMwwRMceJiUdPZ+1plE0FCqJxL+EWp38ylwBJo=;
 b=VTFXOBTgqmjGpxO5m7g1jE1sLPfMuY/BkVRLwsIxodFvFvCMAepZzGESt5f9qCUk4QIJiO+T7Ys4i6iXnShz9IOYKCuexavF14Adcf4CbdfFf8el32JzbQ11/nJjIki22Kd6shMOMavrFghnbM1nzkZuCHBpyUMNzH2wlFgF5m7dClba6XvNHhRssk65ewpKbnPIImiANSV/NqlVrlJnJk9DF6nAExxflvjLWEgEBoUYOZr/npcKcD7ZqJGlVc4wws9TfxGxfrMVLaWyKIBwIdrpUmYqa/h41CaFg3p8VApBElj9MlbV4NE7vcRHvHlaBKD8N7/2dVzk0dFmGu7wVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbG4BjMwwRMceJiUdPZ+1plE0FCqJxL+EWp38ylwBJo=;
 b=cVLOjr/YMhRk7tEbedC3d/ISy2h0DVkRUOSWuLFelOHjBMrUGacyHuTyTdeJZ42C/vJpdK1Epu0BzK7oHQrQSawChhaU/ZYDW2DqOj4F1tr3qRyH6nxfdfPfzOTuy1kubs8qNMdaJHH3121ClsNg30td8xnU34A6wb+II17R2NY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6511.namprd04.prod.outlook.com (2603:10b6:5:1bf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.21; Mon, 2 Oct
 2023 09:32:48 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6863.019; Mon, 2 Oct 2023
 09:32:47 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 01/11] btrfs: add raid stripe tree definitions
Thread-Topic: [PATCH v9 01/11] btrfs: add raid stripe tree definitions
Thread-Index: AQHZ5yWFR3MOJvjDnk27U5ab5k1D2LAbBxYAgAABMICAAJ76gIAACraAgBqmjYA=
Date:   Mon, 2 Oct 2023 09:32:47 +0000
Message-ID: <d8e1e537-b899-4502-83fe-f1d7822da189@wdc.com>
References: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
 <20230914-raid-stripe-tree-v9-1-15d423829637@wdc.com>
 <b1330370-3261-4845-8a1b-f639ce7fe6b1@suse.com>
 <3e1ed108-44c5-4616-922e-542524c0657e@suse.com>
 <c85e00e7-e9d6-40b0-8bc9-7d966bbd1026@wdc.com>
 <e2b069ba-deff-4cfc-992e-ad8e1d9b6f02@gmx.com>
In-Reply-To: <e2b069ba-deff-4cfc-992e-ad8e1d9b6f02@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6511:EE_
x-ms-office365-filtering-correlation-id: ec376c22-7ce7-4b1c-d49f-08dbc32a8a26
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4MLDpLOgAN2uTMU7fHM/j9BG6gXss8eFXL6YmOiuW39yeAdyIgkClo43uL2S4k793gKThyxHKOWt3j3n2mzAMXy+7fiuKQjd5rM1Hmi/kL7oHcPBo4oBrQXhpmV+pdzcj65W0PKLTosDWYDbWL7g4ZlvxilGL45Zm2q3YmMHqyD1nFAHYIeZAS2iaW6evC+l62Vj06/Tu5VK7gsSROVuJ3I9MJDog84vOFffFDq5QpOD7jfbBnQ7qqizeZKU/mnB/z8Kp4eLAbHFektRB8k9atS3EFmAxZGETXx/jMM9Ctm9HK1zRKDwQJl2FpzfiCZ+GlH8IyqVxdJCI8vPASDWrgDcGJ2qYBzUe5+6ZlmVcVxxLlkqkiJvl8mMUJaMdTWUBadz/grdx6QcGnAShGW/FyltOmJPoMqfwu8WMkXh6PPDPHrDOu3k52BQnfwQsHycgx0qRWU35SR6AK3FOMPbylfWIxn8canK7xN91IUcU+w7A4rZmrHfL9zriBDchB2w9sMD3biw9sdpSucGtCF9RcdVs2fMoWtgMXroomHXPHEQScO39pRFEbUYzeiFXm68bfMB7bQOczy81NocxOVFexr3ecsFjZYEuG91SDfpZJFNmcgQjnM1BdNepMCeQ05SIf68nlgvwrCS2RMgKjDhCGDQSy7U5RUwKhvLHwiYW9frWRTX5mI8OYgHx5/6qnS5EhGKD04T7gQQkbF4NchL6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(31686004)(6506007)(71200400001)(53546011)(478600001)(6486002)(38100700002)(122000001)(38070700005)(86362001)(31696002)(82960400001)(2906002)(41300700001)(6512007)(2616005)(26005)(36756003)(66476007)(66446008)(64756008)(5660300002)(54906003)(316002)(76116006)(66556008)(110136005)(91956017)(66946007)(8676002)(4326008)(8936002)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEVOVkVwdlZzcDdOQXpyTm82MC9UOUp2Y2tZR3hOSWQ0QVNIakZHS0ZmTXNo?=
 =?utf-8?B?aWdZbXBZVXM3NUxLa2F4VTkrTTZJeksvM0psaTl3NGNnMENyWWo2bTRXWCtl?=
 =?utf-8?B?TFZPdFBmYjhUcERmTm42aEJxMXVnT0FnRzgxb2xmdVNSUTNRbTVBQjF6UmVj?=
 =?utf-8?B?T25TeXExdk5EWGgvMjFUYlIrcTBtbU9LRjZxNk42dEJacWVVTjlTOVFwTkZm?=
 =?utf-8?B?L3U3ODNlSkxUS0tpajA1ZGNzSDNQTTZNWmwrMGZHSTZicXRvdHQ2RjZSSTJR?=
 =?utf-8?B?VlJsWU9PZ3krcXkyYmtJVEFDR21JNlk1V2lIK202WW1hUmRJSXdXQmNjRGxp?=
 =?utf-8?B?UXdIMWkzRlJ5QmkydHlPNVluaEZ5T2MwVDlGRVRuV21SOUNVMWlLRUQ5aE1W?=
 =?utf-8?B?Rm44VlVkS3dIUiswaCtXSk9mSWRsSGtqdTkrSUlzc0NHcXU0c0RPdEYwSEho?=
 =?utf-8?B?cWw4UlJrL3dzQzJPQjN1bmtIYWpseE40V0o5WXFnZGpyYjR3SmhiRFp0V0V1?=
 =?utf-8?B?U2RjT2VmckRMMDR0OFhtME9NcUhFaWh3YzJPZDFLR0dHeHdxVW80ZXNTenBE?=
 =?utf-8?B?SndBV3EvR0lIMEVQVGE5dDFIWEFYVUVZNVNGWkw0TEp5MnBrUHZuUEhVMElH?=
 =?utf-8?B?aVM3SlVZR1ZGcGFCS0ppZnVRVTJUMWhMNHpKUGpnYTd0eTl1T01xdEtsQkd4?=
 =?utf-8?B?NVhTOGZ4ei9UVUxDK2VQNGRFdGNqYlNVaHRFR3A0bmhIU2prZHljVGxhekdq?=
 =?utf-8?B?N2FHMjkxS2dJUTRNMFdObTFaV1FVelBObWtBOTZmc0w5c1U1UVF5Q3JvcVdw?=
 =?utf-8?B?dlAzMU5hTFlaaDhCMEJ0ZW9YdmJERXVoNFRyT0ZteE5OSVQrdW01MUg4ck5B?=
 =?utf-8?B?SWdpVnBXOGUxL2xlb0owOUs0UDVYNDNmV2JGYnp2cldUWjdKSmh2VGRrMktX?=
 =?utf-8?B?dUFsQW8zNDFwdGRwSjJGNjdVc09lc0dhRmFDbUpSeVJiVlJHSXJ1NFpGTDJp?=
 =?utf-8?B?Ni9IWVVYY0dkUVlpTjFVSWpQS1FlWHpRZzBHZFhPMXR2TVFrQlo2WWR0OXp4?=
 =?utf-8?B?cEdibG4vdU5HVDJNcU5qQjFJQXc2VFhvRXQ1NGdaUkx1elRxY3dxZ2Y0VFJq?=
 =?utf-8?B?TEdVMm9BdWxIVW8wY2tBVVdzanJIRzdmMW9WWU1WNUZDVlIzSko3MjBUK0Fm?=
 =?utf-8?B?QVNGS0FNanNycTBxbkkrbUpQYXlVbDJ0Y3pKUjdGWDZKcEVNa21XYWVSOG95?=
 =?utf-8?B?c3BEaGo4WElOQW55ZlpDOHdVc09HQStJcEJSY0RmbmFSaEFXODl4Qk16RVh1?=
 =?utf-8?B?V1VXRmRDVlhHeitYZVc1dUpDenk3WG52UkUrbzV5YW1raDBlaE9Iakx2WTE1?=
 =?utf-8?B?WE1jcXQzV2hiaWlqajZUMG1EbVVNREYxYStnY3RLUTVyemVQYTdmUkZQZ20v?=
 =?utf-8?B?VmNsVm15RTRvRjNJcnpTYWptNlQ0T2xrZDR6Rk45NXlTWVc2Nm55VVJSaHhm?=
 =?utf-8?B?SHVISjVRMGRjRTh4bExUMlFwSkFVaTM5ZFZFZUNlUUZRNVhUUGJvR05VSGFr?=
 =?utf-8?B?YTVxNlNuYk9RTlBoVTRTYk1qMHJySUYySkFIb1M0amxVQlQyN0M5L1hiTzFs?=
 =?utf-8?B?L1NTK1lxRWVyaGEvZHJueVMvQ3NjMDdFQWcrVFpuNllmYkR6RzN4U2dzbCt2?=
 =?utf-8?B?aTU0RUt1amNCSDVHb0dCSzhNV292V2FhK0VlR203eFZsZWxybEY5QjdIS0Rv?=
 =?utf-8?B?dFJNSmdlTnZPN2VVSHkyVXFpanhtWTBuQncwZGIvMnVrdVpoZ3UwLzRTY3VQ?=
 =?utf-8?B?cXQ4UjRSeHdzVC92SzJjWjdJTUZGL3hLUGYyYm8xUWRMNnU5TTVvK3NxWU5i?=
 =?utf-8?B?cnU5MzBsa2ZuUmNmMkJOaWgrRnRSc0VNM21TZzF5Y2R4VDlnK3Z2RUJYY2Z6?=
 =?utf-8?B?TlNoWmFWMVNBT1hUVWtvOTBpZGNtMlM3b3k5WFE1TE8vNnRHOUp3WHlweUIw?=
 =?utf-8?B?bkZaZG91dGJGdXJhMmpUMEo3VUtQbWNINnM3S0pWNVVzcU5zZmtWZWlhSDBj?=
 =?utf-8?B?cCsvcHRrVXkzNGRPUTNpbHB1UjYvSWhyZEtzWVYyR3FmMGxseTE1SE9UZzdt?=
 =?utf-8?B?Z3FVNW1pZlFkRFNMNzMvS256THBVZVk0RVIwcVMxZktMTURHNURWdnQ3RUt0?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <280D3F36A7FE7D4E92877E3755A8AF4F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Y0oxdU0yRWpSeG5Ncy93RWtSeWp2Tys4dWwxd2V1L1FDY2R1SjdxQnB0V0dz?=
 =?utf-8?B?QzFiTlN6akp6VDhtOUd0WHd3N3RySFMxaXMzeVZpMm9qQ2NRWU9TN0tUM2Nl?=
 =?utf-8?B?T0RodWI0dlhDcDJjUmJ3K0c4K1gwa2NsSzM0Tlc0L29XNjVQWEhkY3B2bmdI?=
 =?utf-8?B?UFhHMzdkRnNXMHp5VXRFY1I2ZmxsK3dXQjJHSGF1aUFsV3hjQ1d6UDNEWEVo?=
 =?utf-8?B?RjlkL1A4MWMxc1lqQS9oUUVDM0lNSFVkbUJNVjFUTjBIWG5YWUVhQnRuM3Ji?=
 =?utf-8?B?VHg5dUZ1eHJ6azBwS1crSnM3ZEZUNWdvbDRNMzBGUUg0S2RCYjRya0ZtOE5u?=
 =?utf-8?B?NU9HOVFpV1R4S2dNWi8wcTlJYS9VaTVYT296allFZFlSUXFuQXpnaCtYMzJw?=
 =?utf-8?B?T3ZScE84b1JVd0o4SnlNb0dhbnQycWlvUkEyTGNIZWlLMXh2cHNNRWNNc1NM?=
 =?utf-8?B?SHRHWlBNQ2JuYnZZZEhLUG9DY1FRYkhZSWdBUTJTM2pjTG1iQVk0VXlhdEVn?=
 =?utf-8?B?enNScTVxZlc1T1FGUnIzdEdUcWZDVnpVMXNUYmc4SXZFMC96eVRmVTJiUFZE?=
 =?utf-8?B?K1dCak83VmZkTXllOE1zaEw1Nk53WURsZE41bjAxQ2VwTTcxUDVCam5ITzFa?=
 =?utf-8?B?R3htZjlKWHl0b0RUZzl0c3hJVlBBVGZXL1NkeHRTUDBwTG5QZ1pBbmMvWjlV?=
 =?utf-8?B?bENLRURRMmFDcTNpS2pSckFUUmxuakpMMEFmVE1xY0VjSGYvejFCTWsxbnRQ?=
 =?utf-8?B?UUtWRTZjU1U2OUtKN2JDMXNROGVacTJWdkVOVVRma00rclYyL294UVdZd3Yr?=
 =?utf-8?B?VFZyY01iZE5INmNqUG1mbDFtYTRPbk01UmRya1pKalFKeFg3VlhVR0pvcVpS?=
 =?utf-8?B?a0thQTkxSlFTcUsrWHBKZHRBSkV5SnhBNlE4NncxWjJ5c0hyYUp3eU83UGN6?=
 =?utf-8?B?QUZnSThOK2JhZGMvNWozWTVldG50MnpzU1dqMnhtdGZLWGtYd1ZRNXVGOFlW?=
 =?utf-8?B?cXFyVHZoR0VRelMwK25pdVJGZDY2NVNwR2w5cFp0aUptUXpGWlkyV3VrYkFX?=
 =?utf-8?B?Q2J1R3ZsUXBPRVU5U1hOSmt3UjBLUmd2TkdDR2sxT3c1ajlOVEFkY2t4VjBz?=
 =?utf-8?B?YXgrb0RlRy9BVlZiNlRHMjhqYzNTeHk2bE4xVFY0ZTFoVUlVSXFFeVp5NExa?=
 =?utf-8?B?ZEwrWGJsdUU2SHJLMlFVUlBYTFJiUzl1anlxY1BLa2Y0VnV4V0lZbDNhSEtD?=
 =?utf-8?Q?UKV5n7OIItL3UKR?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec376c22-7ce7-4b1c-d49f-08dbc32a8a26
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 09:32:47.6780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: El8XlNDIqFZI9uMc6jFMPmQpxbVDtTTzEm0ulRfe3f3JE6zcQtx2V3BM8upFfsGEBc1bMWpRLl/pKtCozGR0L9JMrr1yUCDa37dDAqy17tU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6511
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTUuMDkuMjMgMTI6MzQsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiANCj4gT24gMjAy
My85LzE1IDE5OjI1LCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+PiBPbiAxNS4wOS4yMyAw
MjoyNywgUXUgV2VucnVvIHdyb3RlOg0KPj4+Pj4gICAgwqAgLyoNCj4+Pj4+ICAgIMKgwqAgKiBS
ZWNvcmRzIHRoZSBvdmVyYWxsIHN0YXRlIG9mIHRoZSBxZ3JvdXBzLg0KPj4+Pj4gICAgwqDCoCAq
IFRoZXJlJ3Mgb25seSBvbmUgaW5zdGFuY2Ugb2YgdGhpcyBrZXkgcHJlc2VudCwNCj4+Pj4+IEBA
IC03MTksNiArNzI0LDMyIEBAIHN0cnVjdCBidHJmc19mcmVlX3NwYWNlX2hlYWRlciB7DQo+Pj4+
PiAgICDCoMKgwqDCoMKgIF9fbGU2NCBudW1fYml0bWFwczsNCj4+Pj4+ICAgIMKgIH0gX19hdHRy
aWJ1dGVfXyAoKF9fcGFja2VkX18pKTsNCj4+Pj4+ICtzdHJ1Y3QgYnRyZnNfcmFpZF9zdHJpZGUg
ew0KPj4+Pj4gK8KgwqDCoCAvKiBUaGUgYnRyZnMgZGV2aWNlLWlkIHRoaXMgcmFpZCBleHRlbnQg
bGl2ZXMgb24gKi8NCj4+Pj4+ICvCoMKgwqAgX19sZTY0IGRldmlkOw0KPj4+Pj4gK8KgwqDCoCAv
KiBUaGUgcGh5c2ljYWwgbG9jYXRpb24gb24gZGlzayAqLw0KPj4+Pj4gK8KgwqDCoCBfX2xlNjQg
cGh5c2ljYWw7DQo+Pj4+PiArwqDCoMKgIC8qIFRoZSBsZW5ndGggb2Ygc3RyaWRlIG9uIHRoaXMg
ZGlzayAqLw0KPj4+Pj4gK8KgwqDCoCBfX2xlNjQgbGVuZ3RoOw0KPj4+DQo+Pj4gRm9yZ290IHRv
IG1lbnRpb24sIGZvciBidHJmc19zdHJpcGVfZXh0ZW50IHN0cnVjdHVyZSwgaXRzIGtleSBpcw0K
Pj4+IChQSFlTSUNBTCwgUkFJRF9TVFJJUEVfS0VZLCBMRU5HVEgpIHJpZ2h0Pw0KPj4+DQo+Pj4g
U28gaXMgdGhlIGxlbmd0aCBpbiB0aGUgYnRyZnNfcmFpZF9zdHJpZGUgZHVwbGljYXRlZCBhbmQg
d2UgY2FuIHNhdmUgOA0KPj4+IGJ5dGVzPw0KPj4NCj4+IE5vcGUuIFRoZSBsZW5ndGggaW4gdGhl
IGtleSBpcyB0aGUgc3RyaXBlIGxlbmd0aC4gVGhlIGxlbmd0aCBpbiB0aGUNCj4+IHN0cmlkZSBp
cyB0aGUgc3RyaWRlIGxlbmd0aC4NCj4+DQo+PiBIZXJlJ3MgYW4gZXhhbXBsZSBmb3Igd2h5IHRo
aXMgaXMgbmVlZGVkOg0KPj4NCj4+IHdyb3RlIDMyNzY4LzMyNzY4IGJ5dGVzIGF0IG9mZnNldCAw
DQo+PiBYWFggQnl0ZXMsIFggb3BzOyBYWDpYWDpYWC5YIChYWFggWVlZL3NlYyBhbmQgWFhYIG9w
cy9zZWMpDQo+PiB3cm90ZSAxMzEwNzIvMTMxMDcyIGJ5dGVzIGF0IG9mZnNldCAwDQo+PiBYWFgg
Qnl0ZXMsIFggb3BzOyBYWDpYWDpYWC5YIChYWFggWVlZL3NlYyBhbmQgWFhYIG9wcy9zZWMpDQo+
PiB3cm90ZSA4MTkyLzgxOTIgYnl0ZXMgYXQgb2Zmc2V0IDY1NTM2DQo+PiBYWFggQnl0ZXMsIFgg
b3BzOyBYWDpYWDpYWC5YIChYWFggWVlZL3NlYyBhbmQgWFhYIG9wcy9zZWMpDQo+Pg0KPj4gW3Nu
aXBdDQo+Pg0KPj4gICAgICAgICAgICBpdGVtIDAga2V5IChYWFhYWFggUkFJRF9TVFJJUEVfS0VZ
IDMyNzY4KSBpdGVtb2ZmIFhYWFhYIGl0ZW1zaXplIDMyDQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBlbmNvZGluZzogUkFJRDANCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0
cmlwZSAwIGRldmlkIDEgcGh5c2ljYWwgWFhYWFhYWFhYIGxlbmd0aCAzMjc2OA0KPj4gICAgICAg
ICAgICBpdGVtIDEga2V5IChYWFhYWFggUkFJRF9TVFJJUEVfS0VZIDEzMTA3MikgaXRlbW9mZiBY
WFhYWA0KPj4gaXRlbXNpemUgODANCj4gDQo+IE1heWJlIHlvdSB3YW50IHRvIHB1dCB0aGUgd2hv
bGUgUkFJRF9TVFJJUEVfS0VZIGRlZmluaXRpb24gaW50byB0aGUgaGVhZGVycy4NCj4gDQo+IElu
IGZhY3QgbXkgaW5pdGlhbCBhc3N1bXB0aW9uIG9mIHN1Y2ggY2FzZSB3b3VsZCBiZSBzb21ldGhp
bmcgbGlrZSB0aGlzOg0KPiANCj4gICAgICAgICAgICAgIGl0ZW0gMCBrZXkgKFgrMCBSQUlEX1NU
UklQRSAzMkspDQo+IAkJc3RyaXBlIDAgZGV2aWQgMSBwaHlzaWNhbCBYWFhYWCBsZW4gMzJLDQo+
IAkgICBpdGVtIDEga2V5IChYKzMySyBSQUlEX1NUUklQRSAzMkspDQo+IAkJc3RyaXBlIDAgZGV2
aWQgMSBwaHlzaWNhbCBYWFhYWCArIDMySyBsZW4gMzJLDQo+IAkgICBpdGVtIDIga2V5IChYKzY0
SyBSQUlEX1NUUklQRSA2NEspDQo+IAkJc3RyaXBlIDAgZGV2aWQgMiBwaHlzaWNhbCBZWVlZWSBs
ZW4gNjRLDQo+IAkgICBpdGVtIDMga2V5IChYKzEyOEsgUkFJRF9TVFJJUEUgMzJLKQ0KPiAJCXN0
cmlwZSAwIGRldmlkIDEgcGh5c2ljYWwgWFhYWFggKyA2NEsgbGVuIDMySw0KPiAgICAgICAgICAg
ICAgLi4uDQo+IA0KPiBBS0EsIGVhY2ggUkFJRF9TVFJJUEVfS0VZIHdvdWxkIG9ubHkgY29udGFp
biBhIGNvbnRpbm91cyBwaHlzaWNhbCBzdHJpcGUuDQo+IEFuZCBpbiBhYm92ZSBjYXNlLCBpdGVt
IDAgYW5kIGl0ZW0gMSBjYW4gYmUgZWFzaWx5IG1lcmdlZCwgYWxzbyBsZW5ndGgNCj4gY2FuIGJl
IHJlbW92ZWQuDQo+IA0KPiBBbmQgdGhpcyBleHBsYWlucyB3aHkgdGhlIGxvb2t1cCBjb2RlIGlz
IG1vcmUgY29tcGxleCB0aGFuIEkgaW5pdGlhbGx5DQo+IHRob3VnaHQuDQo+IA0KPiBCVFcsIHdv
dWxkIHRoZSBhYm92ZSBsYXlvdXQgbWFrZSB0aGUgY29kZSBhIGxpdHRsZSBlYXNpZXI/DQo+IE9y
IGlzIHRoZXJlIGFueSBzcGVjaWFsIHJlYXNvbiBmb3IgdGhlIGV4aXN0aW5nIG9uZSBsYXlvdXQ/
DQo+IA0KPiBUaGFuaywNCj4gUXUNCj4gDQo+IA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZW5jb2Rpbmc6IFJBSUQwDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJpcGUg
MCBkZXZpZCAxIHBoeXNpY2FsIFhYWFhYWFhYWCBsZW5ndGggMzI3NjgNCj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHN0cmlwZSAxIGRldmlkIDIgcGh5c2ljYWwgWFhYWFhYWFhYIGxlbmd0
aCA2NTUzNg0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RyaXBlIDIgZGV2aWQgMSBw
aHlzaWNhbCBYWFhYWFhYWFggbGVuZ3RoIDMyNzY4DQo+IA0KPiBUaGlzIGN1cnJlbnQgbGF5b3V0
IGhhcyBhbm90aGVyIHByb2JsZW0uDQo+IEZvciBSQUlEMTAgdGhlIGludGVycHJldGF0aW9uIG9m
IHRoZSBSQUlEX1NUUklQRSBpdGVtIGNhbiBiZSB2ZXJ5IGNvbXBsZXguDQo+IFdoaWxlDQo+IA0K
Pj4gICAgICAgICAgICBpdGVtIDIga2V5IChYWFhYWFggUkFJRF9TVFJJUEVfS0VZIDgxOTIpIGl0
ZW1vZmYgWFhYWFggaXRlbXNpemUgMzINCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVu
Y29kaW5nOiBSQUlEMA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RyaXBlIDAgZGV2
aWQgMSBwaHlzaWNhbCBYWFhYWFhYWFggbGVuZ3RoIDgxOTINCj4+DQo+PiBXaXRob3V0IHRoZSBs
ZW5ndGggaW4gdGhlIHN0cmlkZSwgd2UgZG9uJ3Qga25vdyB3aGVuIHRvIHNlbGVjdCB0aGUgbmV4
dA0KPj4gc3RyaWRlIGluIGl0ZW0gMSBhYm92ZS4NCj4gDQoNCg0KSkZZSSBwcmVsaW1pbmFyeSB0
ZXN0cyBmb3IgeW91ciBzdWdnZXN0aW9uIGxvb2sgcmVhc29uYWJseSBnb29kLiBJJ2xsIA0KZ2l2
ZSBpdCBzb21lIG1vcmUgdGVzdGluZyBhbmQgY29kZSBjbGVhbnVwIGJ1dCBpdCBhY3R1YWxseSBz
ZWVtcyANCnNlbnNpYmxlIHRvIGRvLg0K
