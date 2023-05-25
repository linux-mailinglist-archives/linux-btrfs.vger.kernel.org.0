Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA80710CFC
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 15:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbjEYNHJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 09:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbjEYNHI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 09:07:08 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EDE135
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 06:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685020026; x=1716556026;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=CC1gCmNlkz7IReAY86GGlNEDS/l+DGY+AJ7l3r5P+U4BvP7FUk2vlK+A
   Q9dAktsoOj+fJtmVB2QyrcoANKKmTLNiybcMzgEavfgvSXAxlXZcxqwqc
   cc0qVruE7l4pZRzxfdg4N7ZhqXLRY6MOyIT8qFniynmH99vggBp3pQ1/4
   yJ9eXAiFdt2HweRnevu9egHg6H4hzIDG1kKVFTAbyzL+JGemKin/a01lT
   mbuCmVwZ1qGLvt2/SllAbhAgZbY04cxbqin1HQ86r989eavNU+fd3JJdB
   3BxdFu3AYDROcfMLGqj7iAEXZx8wl25/z7UmRrB6HCVJjMlWuTUGG8Klq
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,191,1681142400"; 
   d="scan'208";a="343722255"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2023 21:06:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAFD6pwybo3qb7gmOpk/OEeoF1KI1Gdjqb/wsFe9/cba+yC4u/r+owaL8QERiUGS+ryHmyE2qwPyjhhRnH71KCpU5xal8n7xdEjacshZ3xNjDQ2g1Rf8EIjqA6V64kD5rg74RiD83UsffMI/dOMuBBezDpi9n5wbCXaLX22gIser9H6nDZ26JWZA1xCztF7z0DZIBZbVJNJsJIuaGpIdQU5abUmsKoVTsHYd3GxGcGqZFFnXTenB0SkIz1WlRwLKcY+FDgcitAvXcOumm7pSir9x8abo0mdyic0xWoVUM+2IcSgMgZ50yCqJlrJV8ZGWAKz8eoOJEEPBDQOJZo+eDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=WyuD1sxw1DsuFzv6N30sdLZw46+VxhGhpo05KQz3mAkOHx3ITlhUjMcP3laLPAnu2e19p+1YrqnfjaEPVTiJug/T0IvlTIzz1gR1hy9vvNlZVc6LFxZL4ecO3vpHDW/1E6UnIkx7VxCnhoU3tR1xzvgkJXUDnRPTb0uDelA7FtzBOLpzB66/vsDXjPvgAqNafjY8d+gVC+C3rrBojgoIhlj6f/qW5it/dbum8eyzfYHx8AMAgn6X8DEY2TdkiDUHh1rj+mbMlNOoKCjhPIHzox2AgYs+lJt3eEueM7q9JCDom+33sLDvBOb9NtwhKsTkZqgUzyd1sSc47VK3MQaMkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=u+NhYuS2X5BU//A45FFG3y0z2D0jX6mACev/Q3y2aWjP3ffH1Gicch1VPEGd7jINSISzCCmAODDOHvfWkk+RWUG31Ro/1bE2r1fbu38zPdvH9oom7lNbBRY5fk2N00SAbvQQGZEGAXvFxDUnnj7tQktx4naL23NLguRCgCbzOrc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW6PR04MB8884.namprd04.prod.outlook.com (2603:10b6:303:246::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Thu, 25 May
 2023 13:06:50 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6433.017; Thu, 25 May 2023
 13:06:50 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 12/14] btrfs: handle completed ordered extents in
 btrfs_split_ordered_extent
Thread-Topic: [PATCH 12/14] btrfs: handle completed ordered extents in
 btrfs_split_ordered_extent
Thread-Index: AQHZjlD/IuA8+jODbEuBsskNx+Dr+69q9ucA
Date:   Thu, 25 May 2023 13:06:50 +0000
Message-ID: <89e3d6b1-3e5f-a04d-3223-768f63eb5160@wdc.com>
References: <20230524150317.1767981-1-hch@lst.de>
 <20230524150317.1767981-13-hch@lst.de>
In-Reply-To: <20230524150317.1767981-13-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW6PR04MB8884:EE_
x-ms-office365-filtering-correlation-id: 43671c99-61f9-435f-45a6-08db5d20e74b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xBsmHzSGzfWW97MxUyojPzG62OkmZGU0uniKWlWTbLYm24l16R1Stwe4lAOc+8ZmI6C8GeapnhrQdZY2KpXB2G7AJ8KbigCJVAXts4CLvt/kCdnnCKEGptghdLwGb1/LLn63imwyysiNRdpgzgq9Ky1LFFsACk17lUQUHfZKzfjn7zAkeF5Vq7lKZ7J1wkbdrEuJnpJMHCJMmjwyYIlx7K5lQnhSWag3Rs3Ibgw4HbMgsDuUULIdib5r8VJXdFwUmInt3IZoQ3ia0RJShgOL6lrFAYFShwXzpd256wZSFgpi0rnxKG9iCquRZhKmmOMDKcpScW2Fvu7BIFKCNlEsE9O9MR2XOiExWnlARkwbgqqK4sbRN2IRxsQ/9nBZqahM9TqSie09Zz402cvzU1qflxuMYvIzURdZ1cncixVX391KpR+MFeXw0wWgteNMacR96ivRRQKJPkbkiXEIIJqY+4Iwj8H/TKiniIb2lrd6hTKR0R2EO1vJMjYvkBoNSSj+gQawrM5lgeFYTcsC06i0WHSkxP4d0MBTvt2zSHE327yr0XNJxBACDDTRrcw50N2ARrev97P9w+xBojnT1EGCTfpp3x/pcg/y42GrggzoNp0tmGkQhsR7WREqPZjDkx/RNKGJzAwNkWyrnDBA6ziNZfgHAW0fKqJ+UIFpNb0E3Eb+ra9p5TA4GDAJYvgh9rv/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199021)(558084003)(36756003)(4326008)(86362001)(8676002)(8936002)(186003)(6506007)(6512007)(41300700001)(26005)(2616005)(4270600006)(110136005)(5660300002)(38070700005)(54906003)(76116006)(316002)(66446008)(64756008)(478600001)(66556008)(66476007)(66946007)(71200400001)(19618925003)(122000001)(82960400001)(31696002)(38100700002)(6486002)(91956017)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWlQMmRhY3hnQW90b3diTG5GbFpCUmhWdzFWOXpCMC96blMrU0oyYWNOeVNu?=
 =?utf-8?B?NWtiZlVuUWNuY2RNaE1ZYjdWaUxEMWp3Q2dWQWk2N2lkMFJFNnhFME53eHRG?=
 =?utf-8?B?aUkyeEF4RDJaUEdXNm9KQWRnSEFyVTVrTkRoWUs4aExnajlUWFNicmZPQzVu?=
 =?utf-8?B?SFZnQ1dmOFRWQlFaL2Y2QjBDQmorbWQ3SEF3VjJNK3gzWm9Pam9XelQvZmVH?=
 =?utf-8?B?NFBaN0dtZ0NJU0ZWbURqSHUyNjhJQkRxU3ZjKzAvT3N0Y3FuRGpObG1zQ09Y?=
 =?utf-8?B?ckd4UjJkOVluVUEwS0N5WFFLMXd1MWlMd003cmpKQ1l0Q3ZCS2pGbE9tUFc5?=
 =?utf-8?B?RjZRWDRTSjJ1cVJQOFVDZ1BLVmNOak0yaDBOenpPV3BMNUp0U2xuU0VTMk41?=
 =?utf-8?B?Nkk0L0dWb3BYbkJvd1hubTJ3N2V5R09YSzVJV2FtWitHcG9Udk8xcm1XZy90?=
 =?utf-8?B?SUFOcVZwcGtYdGczODlUaUdJOVNCSXZQR0RqZXdtYStpQndYRU8reG1QUnRL?=
 =?utf-8?B?a0huUkVhaFl5QjZwY1BDMzFHTkp4MDgxRy9MVzVPMVpHZEtCbjNieGd6WnJq?=
 =?utf-8?B?UmdIOXA4Skpaa1pKeXZwdXZDcXYyR2NzeEVVTkhleTZyMzduZTRNS1Bjb2Y1?=
 =?utf-8?B?aWxoN1ZBZEx3Ymt5dEpjY3RkQUdhdXlnbjBTam5EWThJL2g1QUxjWmUrWjhy?=
 =?utf-8?B?WWxhSWMvWjNrR2h2RU1Kb3ZJbXhVSGFXenBHRHR6ZGtadVNlOXVvSk5zRms2?=
 =?utf-8?B?Y3p0azRkeDRPOFNQMm5VME1YblVqZ1dmbE5teDFFb1JHMXFKc05MN21KbkJn?=
 =?utf-8?B?V0lQVjd4VUt0d3NzbHBKVWdSNmwrR2FLU25pUmErb3FrZkVEbW1iVTdSOTFH?=
 =?utf-8?B?WjMza1VqdWo5VS9aNUVkdEZNcjJHM091Mi9zekRqK3V4VC8xQ0NCZE5mQ29C?=
 =?utf-8?B?aHYvdFAzc1JDalB2SGM1RjdPaWM1bWVWS1JHZWNUUStEQzZqY0tKSnZLNmFI?=
 =?utf-8?B?VUxkdGp0em12YS9uOEhFTmlSeHk4bm16dXVpeU81SVVGbFExaWQ1V0ZWdHZi?=
 =?utf-8?B?MTQzbXVyN01MdWQzRk9BcVVJMmJOTVRZdVVzNm5kYWZCKzBJS0kxbTlYejBm?=
 =?utf-8?B?RmttNDdkTGxRMnBqMmEyY2pndTVwa0ZIaE1IZi8vR2duRTFLbXZ6ejhsb1hH?=
 =?utf-8?B?aHQxOUlDSEY0UUNQZml2NWcwZmk2OXhqanY4SVZYZmZucXB6c3JCNkVCNllm?=
 =?utf-8?B?ejZhWGxLeHZLNXBqMmx6aGFYd3VwVkRDU01PTjdXdUVwNmd5K29aSHJ5MjBJ?=
 =?utf-8?B?bFBOOXVGNmhWeE0wMU1WdXBEZitybjlod3VpTk16YWdxdHZLN2VWZktsRkt2?=
 =?utf-8?B?Q3kxUXRvLzR0bCt0VlJqTSt2V0FZWUt0YkUrQlNNVHFMR0pWbWxJTkJRcGFn?=
 =?utf-8?B?NTJJSFpmWUh4SUZnSXZiRm1ZMVRxaldpdldDdVp6VjE0SnpLbFQvdytIcm9x?=
 =?utf-8?B?REpHZHpRYmhDZ2c3SHJaOVhQL1hrOGVoM09IL09icFJYLzM5UzgrejE1TDht?=
 =?utf-8?B?eVB3QUhKSGRGd0pmZUlZK1ZXNnRjTHpDQVVQMktFZW1lbG9YdFUrOTdLSGE3?=
 =?utf-8?B?OHlmU3dnelpTY3hJbkt3Z1ZnRVNPdzhyeGwzWjBGbkdueW5EYm8ybU5qUXFq?=
 =?utf-8?B?ZmR4OWxJMGpXOGhUNVE1ZlZJTWU5OTRIVDdMQjE0d1d2N2lQeDNsN3IwaEhq?=
 =?utf-8?B?MUNpa3Y3TjZKNFo4cHczOUJIVGhDVEpyRksxOEpxUlZsSEhLTzRDd2dGYVI5?=
 =?utf-8?B?Zkk5WjFjMTg4NTgwcmZGaTB4U0hVb2Njbm16dVdBdGpielIvb0ZKOXdpbWF1?=
 =?utf-8?B?MDkzMUZQRTVIUTZYR3lsMGR6d3l0Q3lyeTlueFBmUjlPYVhhOUpFdkladVBP?=
 =?utf-8?B?cTlCQ2NIRXFFWWRZenpueGdNVTVOSjVsKytSVy9Eei9KT2tERXM5bllDUjBk?=
 =?utf-8?B?blhOMkFqQnpYa0hGQ01Ea1pmdEhURWphbnN6dVNvWG5oVFZnSTdBenZySzky?=
 =?utf-8?B?bTJmd0J4NnZSTU5nTlFmUE53Qk5BV2Jpd1paSzhIN1VyRFNBV1hqekhEM1Nv?=
 =?utf-8?B?aUg5UlAySnJxbkxNemk0dzd0RGZUZHYxbTdqclArZWIyS2VlUzBFWXpzTWIv?=
 =?utf-8?B?bnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D094E22A07A9AD4086A2F251AA3DB4B7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8thN02co/CKou+lGUBAf8sxy9Air+BL8JB485hqOhbL9m5doflIV5JSkMVQc0aJb4cC5D643V/jNieHb2mejCTJQMqe+n6v6ir4YeXT1Vagk/aJmo5KW91cIZgc19I1PEbltVHfba7LOqAWD6+gQ9W3RmP8+54krRWTvt9hcnCXtnVSjbGsy/EsILFkYM5YYXdpd3tmV8RUwbv/4qiVG87QR7ksT+2VVEzZ9yQVwztPW2o01plXQ7IFmzblaTF/TXD11cap9Xf3woJPJzOV+NJp7zESIwKYZCOhNi6mMWJN9xzsfa5em6Ia2BkMuTGzoYSpF5nBalD6UbGTu0hrJnEmXpmJO3QnCyuEzyZHFY+aVY6mpG0ysaIkGdbw+6cHmvnvSgCEqxOOu56QNp2wkM/24z9/F8Cu0GycHPRzn7uXnqvSyoDWSd4NBsT6D9aqleEIqaqnIafRVI3TiQIeGXtSs3pRrKrMiZBXnMKI60NjXO3dhyC/xrTln4eNx60XXavM7ClCvD4CTM5ugdlRlZZ27tJpiFlo/MtC+fo17XhMPaMW52Mo76OL8jSV5ImmmZYIKAzQbui4ejNLoFRpeqFstHxOu08fjGCVG5F0uUrCQ3yRS/Eiw12t2v0jGdfNOOAFrH1ktemCg/sc1R8tY1RnoEhJbFshdHsISSTToqiX4j4gmkJxTLnb7kN2rFxXv2mpWfyAYUEkRytgfvUuY42frltCKCLrdeLnwq9bJMNRMm0uGVvub8+dfdW4JAXq3OgyT+e41uchC88HtzOwFWURvq7j3zas/UiFoiDGBOafXOjzNwm4h6PwNKljM4WI3+Fe+VjWisbPwR4wXp6zXKj4upBKar46g6WHQmcPU42tL4jxuq2yHletUOQ/vVamG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43671c99-61f9-435f-45a6-08db5d20e74b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 13:06:50.3587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pDABIJrf/7bdEuU16c2wUbD1BHuVUaQtrk7IRQrHxrAEymp6uXyoT3FyCAQm3riYF0mF8b+5UT7lQ0ZBp4ixDrpt0O3g80u2x4rRBcv1wyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR04MB8884
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
