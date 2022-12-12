Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23A9649E58
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 13:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiLLMCW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 07:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiLLMCU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 07:02:20 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57027C35
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 04:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670846539; x=1702382539;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=HG8QzVndjnkU/+mb2E8dRFjY97PSoMXOru4WFSV3RG2E6IMpL9MhMPVI
   hgJk0OgSSPbO95M2PRmfcRf/M/V28sFIZvwIL5dNquOuLFc2Io+FYEzyi
   2WcSUMv9CkH6tEI8IVvZ10Owfu1wWvjXspcjK7kfI7XiYH7U1vvtzM+pd
   O7My506GKaWvSEU6Xim0/wZ3Hh+dZZo5Zz6GGIJ3I0RY6hYcg4OzS+iG8
   pOwZ/ZzlLKgYbL2g841Y1ShiKKE47VS67ZvUtLnvfRqRDMJhdCRz3ugE+
   RuCLtKj8/VK9UWNGRJFtH1c9rzXKKdikoCfnqNeaFhXxYrUCtoEbJP9pZ
   g==;
X-IronPort-AV: E=Sophos;i="5.96,238,1665417600"; 
   d="scan'208";a="330531468"
Received: from mail-dm3nam02lp2042.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.42])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2022 20:02:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiG1Va+kvApkhOj6z7dk7eLedo1ICxvBZl+Uh/CS25BMIliCFBpB5Mt99vQXo+j+O1tT50l/muOBKlVoZrJq5TO9cuin6fQm2DmsFcFEamhLl/gslyeOAdsPUAAG+6zs3QfihWWs9/CILhWgQBEUxFKC8yOz9xCDzBHwDSYqA9F/OCnD33g18lPd+abOoVup+ZZ6i43goLTJZ2nrTdASEDhQqv55L1iHc9ERKB7v/qf6lL0ofIWRdpll4HGJzH1/Q7JDz7VOQomsQCeoKYZhbZEJswsx4sHTrY5ny5q/WGpHRK6eiMvkp8QvT7mRNZn9B29sf0LxiMF7mZtgZADmxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=WPRJWmBIOJkrrt+1AAxpHnaISGbJGgx3j9YV7SDySKCEefPN5M91oaXGys1ttuW4rmLEpxM4xdjpaGrpr9Ldb9U5qz1KagANAZl8ETEc7e/27kqRgXhxfvpwwhaSr1wAO2qTJfFtx1/p67xKz1i6ldI6ZrEpcSh0543KGUyUcVVtUmPJOhUdkYGPC2g+dUS4+XaCC1X3s5gAsjYE8ty1zkKPjfGGGsnu6gxhSw+X46ek7AEc7sFZOWLHEdJtE9Ua0HjahHATKSi6W5lY/v1Xz9MJfWDu8NlgqAXT/mcGP/VA7jLivb8fO9b6Rlh+GcTDieZ434Y8p1PRTjF5hHvHog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=OqwfpN+2PQYPhbELZVk4wa+pDTtZyv/SGxFdZBuh/1AoCS47VLM6wO6mEZcZqUlQglx1VixHRXW9knRK59tkQlYSBXsVqrO3stWQ+dQtrYk6lJ901r0ZNYOCbfREelLEjRLW9HvWTzPwXiH2/6ZKaCZ7jiv6YiNWdNifi+7RNL0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR04MB0827.namprd04.prod.outlook.com (2603:10b6:3:f8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 12:02:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b%9]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 12:02:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 5/7] btrfs: never return true for reads in
 btrfs_use_zone_append
Thread-Topic: [PATCH 5/7] btrfs: never return true for reads in
 btrfs_use_zone_append
Thread-Index: AQHZDfyqdJqAtAI/dUW4dlCqQC2jqa5qJysA
Date:   Mon, 12 Dec 2022 12:02:15 +0000
Message-ID: <ddda2183-cc19-3882-94ef-2885ca02f638@wdc.com>
References: <20221212073724.12637-1-hch@lst.de>
 <20221212073724.12637-6-hch@lst.de>
In-Reply-To: <20221212073724.12637-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM5PR04MB0827:EE_
x-ms-office365-filtering-correlation-id: 5df55367-3c05-458c-b87e-08dadc38b5ef
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I8oJ6QDocRHUXol46C4kv4gl/Wb5OIotKnAlx7+wkACNTwz/LaZCqiq6FLoExMpsJwxaTQ07DqrEq8eB9VJ9R4BPf+zul3V+tLD8o4tmNv4LWDvwwyRwCrpWo3FoieycGg4tTtLKiEd5NCzsF4gKnzY+oo3hI+CeqIxRszzEdGuzdI8Rj71MwcI/iL7Vp8O//a51xwzZiRx3cGeXqFfL/PmNWio96rWWPk/7hVR0K0eAbG9VL7ElhSggsf4AWPgmxUuDp/+1MDTu6tgbjfPqW3IN3ZpI3sah1tgUl7L/rt800OB14nqcIyydZuLcGizS2dQTfiT4mtM4nA9juzcEVyZ+9yi17SDxnVsdvsMYxECtHcbYmq/NM1fOvCosg5Ek9vyAuGWn0zUFV9YqN1fHMCJhimGX9dSA+r2EWMKCkWaMTPbxLHBjR6lAVSltZr9eKbU668OfsYKmIhmWGhGW/BImnfUcJ02m53UpnZZ5blSDLru1qtpcrhhKnvRT75LKPP5Bt1hUm1Gr6i9c7mCd1hQetQ+3AlC53qX7toQyhyl+Cbrj/fm4L8kifiqYDHQdn33VAD2XNsiYBerTn6HKsIA3tf04za85Z2/eQA7LJfGPzN6eYUHd5HOfpqsm5qz+ptKfDvv5WWiJJ4P1u5pxZ2v2YpvtrjExZCijPZzK0/m7vZcaNDfs1q/XeyAsTFbnwbHthWTVePAZGaENNSRrYKAgjAmk5CI2PW55pP88ZOjMXk7Ov825yGME/xh5m6x0HCO7MMUXI5XOrWDxqC45pA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199015)(91956017)(31686004)(36756003)(558084003)(38070700005)(31696002)(86362001)(82960400001)(186003)(38100700002)(478600001)(4270600006)(6512007)(6506007)(71200400001)(122000001)(6486002)(2616005)(316002)(110136005)(41300700001)(64756008)(19618925003)(4326008)(66446008)(8936002)(5660300002)(8676002)(2906002)(66556008)(66476007)(54906003)(76116006)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWVXWjNQMWNrS2J0QlV5R21HV1h5eHZEUzZGNjNUS2V2VFFyY0F3cWNBQ2U4?=
 =?utf-8?B?Z3QvUVQxRkpJTEhMZDlBWk9EVUJxQ0VTckdkQloybjhwakVPUkJlbXRWMWJC?=
 =?utf-8?B?Y1dONm9rZjV4dHVmdGRLdmdwZWJxQ3FubGpvc0xJd0xMcDcremZpRElHOW9m?=
 =?utf-8?B?eEdXa1MrTjJNTkNrQ3UrWGtRbkVJVnRubUo4SndnZ3F4NncxNG1PWjVQKys3?=
 =?utf-8?B?bjdlcU03azRGbXVlZzBIdDQzWG9OMzFoaFF1Vjg1dTFGalh1eC9YSmpncnZU?=
 =?utf-8?B?WWtwM0tqeDdqWDFzUlY0SWRjWWpPLzlXV2ZoWXBzL3h1RG1IWWRJS1lXWEFy?=
 =?utf-8?B?RWdjQkZ5UmxrNnJndm9raG5hcDUvS2VKVmVCeTBra0xvWFZEVHNWQ0VxSTh3?=
 =?utf-8?B?eW91Y2t6aWZ1aWxUSWhDUm5UaXp3YU1oY002bi90elBOTEhZSytDSVBoK0tL?=
 =?utf-8?B?bkJRTkpRNHhUSTNjV1FNWnFpTUQrTUZHNk5Fd0M3TklWQWRlOENhNWVESFNh?=
 =?utf-8?B?dUNPMTF4T0dVQnc1OFFEa2pTZ00rN0d0ZS9NRm9hMThFMDZEOEhIYXRQVmd2?=
 =?utf-8?B?bnpnY0hkTzVSajRmVHZWVXVBLzYxSklpRGgzQlhjRkNMRXRYSFVoWFVzVUVx?=
 =?utf-8?B?RDFaZUp4dGIxTmdoZFFVSlFBWXB6d1RDNzNYL0NJUnRJZkhIS0pWK1BvYk14?=
 =?utf-8?B?YWlPTEJZNjMrWm9iNDhIV21oL2pSam4raldWRWlNRWJ4ckRiMEkxQ0NhVldx?=
 =?utf-8?B?WU1kU2xYRjlaeENRNjJ4VXh2VjFOL25RRnJkWmg2djlyYmVXRUhRbkI4MUUv?=
 =?utf-8?B?akhTYjJDdTllOVJwWFVibFFFYWFqZU5YbGtOakxqWFVMQWtBMzgrM2EzU2J4?=
 =?utf-8?B?azRibHZKUkxQYWJZNGdoQzdwWStJT2piT0V6V3pNNDlSMEtPTnhSb1doa1E4?=
 =?utf-8?B?ampaZStoaHk1WWtIV3FwTGRRMmhab2hJcGhuR241VVpsWllSdFFmR041QUlh?=
 =?utf-8?B?YzgyR2VvYW8vSkU5eVpjdmRLenVOdHhSaG5ITTNFMjZCOWw0Q1NDWkhac1Jk?=
 =?utf-8?B?dCtsWDdWTE9rRVBvbm96Wnp0Z1oxOVdsQWhxcWlZekQ0M0VBeXpZa0Z1U29Q?=
 =?utf-8?B?VExjQjcwWkN5VVBkL3FpWXQ2SWNlOXBFbXFqRmtqUXNBUjQ5S3diUnA1ZGsr?=
 =?utf-8?B?RWk4TUVEOThxNnEyeFB6UlhMTW5qSzZDZy9POGNpUW00TVlFbGZUSXJJTnlz?=
 =?utf-8?B?YzFITUZ1NWdTOWxrVHdxWTJqVWE4ZXV0S2lUbzg0S3B6R0docWgzUDlGZTNz?=
 =?utf-8?B?dmtRczN6UVhFSE5PUmhQRnMramxtbWVjWS9tY292cWwxSVhQUmlWTXBGc0wv?=
 =?utf-8?B?Yzc0YjhQNWRza1FxNyt0Y2ZrdUFyYUc4Q2gxU0V3TitaZVVYMkRmM2dTcENz?=
 =?utf-8?B?a21RUVM0Z1dKSzRNZnVGS2liNURPbHd3WFFnV0lzZmMyN2RGKzYzSTVoY05N?=
 =?utf-8?B?NDRLdTZ6NFZPQkVnYlVVNzY1WEVYVFZHbjdhcGhsekxpdWQ1cytvRkpQeURP?=
 =?utf-8?B?cmlFZ0RMZG50aldyeDc5clhzYXBDQ0lLQTlUZXRHallNRU1lSllHQTlZdkoz?=
 =?utf-8?B?NnZ5TnpNR0ZRWFRBTWJuNkhEZ0NqaE9sa3M2ZUdvYUVveE9FM0prUzBDN1Vu?=
 =?utf-8?B?UzVvR0k5T28xTy9RUkN5SUxuMXorcVE3c2t0aEJ5QUtjS3VSMlZPcGx3QXNM?=
 =?utf-8?B?cjhZcFRkeXpkYzZRUGtyM0Jkc0tiT3psOHNRZTdlcHlrUWhITVl6cEk0RkVz?=
 =?utf-8?B?MDdIMnhINDVPSEZsTmVUYWNvMG9tNUJOS3VKQjRhUFMvKzZQeFJxYklDMXhv?=
 =?utf-8?B?UXdDWkNZYmwweGZyQ3NLcmZzMFNtTnU3eEN5Mk9ac1VFeG95cy9mblUvdTFr?=
 =?utf-8?B?dU9TYkUycmI0OERDWlY0OFRxcHdUZUhNRE9LUU9OVithWFdRWjIyVGdpNkwy?=
 =?utf-8?B?eEZHVG9COFM1RXFRYzdZOHVoUkJ5NG9NdUp3bG5qbHRxWTRRQVl1aWdRUDVP?=
 =?utf-8?B?blBEdTJ4Z2JXTUxGN3NSR21ha05ZTk5KZzhuM0l1SEprWlNNOGU5a095U3RF?=
 =?utf-8?B?aFdzR2NNeU9QMkRQWHVMNEJTQjR3TXdVZytZdG9yUlFadDkxZ1cwVDI4SzRZ?=
 =?utf-8?B?eEwwNlRtd0RJTzJRYXJrK083alRCaXczWGl5c1ppdlVTOTFRdDVMdjUxRWVB?=
 =?utf-8?Q?zOgeTdSSgaud5wHJYerf4/zal+Aj07FavYewRo9G24=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FED90D9844C874B8BDD4E18D7031111@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df55367-3c05-458c-b87e-08dadc38b5ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 12:02:15.4699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rqgx8HVH5QmLTO0Mov7GSchVtd7chcnFj18gvtZd7V5FDZp3ESVJNjU2QMPsdFbHdi9rly9JlfIekrKLdKfKejz+X5412UEGjg+HJ4f/Mww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0827
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
