Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2837A095E
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 17:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241065AbjINPfQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 11:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240810AbjINPfP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 11:35:15 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DCBCE;
        Thu, 14 Sep 2023 08:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694705711; x=1726241711;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cSRWZondrSz6+cDNmi8z5lRsyIWrw8iqzlGqdDHtsgE=;
  b=H6KfjgDJv81IhE12gXU1OWbJr+qaqiNVJZ873IQAyYZ05udyMIkikUUs
   GcKrUwmBMrFWapFwMAGj11hxVeGBsFO+PJrp4r+DgpcmKVPNmS2CcyqUA
   rP6Wms4jw3KG1qybJUjm5LmsdKECOUvQv3tZEhPHeDN+n2FTpEbpbC3Ax
   GR2G4CDnXi9+jn4WGqbDyuwIRueEG4YloN94l9nIu8mVuahAYolINIjWb
   IO5jykukSQXfkyErW5kiXkTQiKiHfpQKRwYfRkzKM/I/0GFEbj3kamBoB
   faZq8SZSk4uOy+AqE979HEglRBtqpvp3e1ei/EgOe0mVZZghHeybBPY9t
   Q==;
X-CSE-ConnectionGUID: HAY+9k4BQGir83Ksgn2qzg==
X-CSE-MsgGUID: CO+/MkdlRny5/xYgML1xvA==
X-IronPort-AV: E=Sophos;i="6.02,146,1688400000"; 
   d="scan'208";a="244306379"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2023 23:35:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQ9mbHJu4UujFiuMZ0NK4Ak3c8JIWR210ZzUT1jbjmAxoxBOBedOzn806nsewPWY2Sbij+EjsbAEZYFML6UM8wVpg9x3KZ+V1tb8+F/9Ev6aQK7XvipyeqE4adjNyTBBbA0W/rBcDqDh7muQzRYn3xUXvdD3PhI7K/cEzMa2MYV/aU0D8Hr4/eqhFd+1/7npMVNAtQxn9yuIVTJBSntlfpzG2qb1r8MLyzBBdIdcMIy4J6bsLYOc5gefOqqDAR71oJNawVwtipsOL4ZVWUPh9UOMY1GRUDW2dZOgW5cZ2B40x0NhxEuyYS1LWnktBNsq04+rc1lQR/brDAfC0SqEoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSRWZondrSz6+cDNmi8z5lRsyIWrw8iqzlGqdDHtsgE=;
 b=lWVdpmn7PfCD8pnR7QmURQRgohwFWWvM92wH7dKkwAqfbGubq0WaATH654l90xgePuQjzICE5vl74yD3nAyZqy0WAJVu0veHo18MmD3ULzsNxcYDfY7fo8lkuIcjyr0uXHe4t7BhnkGeXkotOf2Gq7w7XRG5cqjy7zKCkOJxcdJEomzce/4XqIrcB/9apAgg2V8kD6FgyvDt/XuGS8iva17Q2ZLAYMYpQBm6p5JZ5KpGIAIkbX++UfOwp/ZtrIvelEI0f87xdgJZ0oPPJeu6VWCPzqGBnzw4+zVQWuOUV0NYJwZ+6tJgzSwA21s8LRE+e4Q3Vg2OHaIos9+EQqDPKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSRWZondrSz6+cDNmi8z5lRsyIWrw8iqzlGqdDHtsgE=;
 b=NDltpw7qz7CofUZxXeVDD381IBrDBirgB0oSWLzNSpwJcfoI45ux9qlcEirYmSk9d5sOKrNJgRQ4CpNgwW76HLlFaCOHaH0JHfQMOJG4hUVYzhsimMKoOTK/DExLhyIekFcq/9R3HIOH91grlfokCkHnUBFW8SGrYp1fWd/EsPs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB8087.namprd04.prod.outlook.com (2603:10b6:8:2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.7; Thu, 14 Sep 2023 15:35:03 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 15:35:02 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 03/11] btrfs: add support for inserting raid stripe
 extents
Thread-Topic: [PATCH v8 03/11] btrfs: add support for inserting raid stripe
 extents
Thread-Index: AQHZ5K7alMSnA6X5wEKXERceny6RlrAaEXKAgAAHW4CAAAQzgIAAW66A
Date:   Thu, 14 Sep 2023 15:35:02 +0000
Message-ID: <477fba84-b411-46c3-9851-ef7e30732db3@wdc.com>
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
 <20230911-raid-stripe-tree-v8-3-647676fa852c@wdc.com>
 <a5d3a051-0b3e-4fc5-9df5-e70c94adb95e@gmx.com>
 <2ad7c49b-89ff-4f10-b671-6b2ba4ccbef7@wdc.com>
 <2f9f3e43-8a4b-4dbd-9e10-2637bf7079ec@gmx.com>
In-Reply-To: <2f9f3e43-8a4b-4dbd-9e10-2637bf7079ec@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB8087:EE_
x-ms-office365-filtering-correlation-id: 462c4537-ce9b-4d4e-9812-08dbb53829ea
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vHKyxqIDQWgsXfdy0fq1/Vh+YqDXfqCpX13YS7ZzmYTkOQZ8fPAjZomdLIpq5o+2dsCCQLDxzjdCv4prKnQhxC754Ui/FL4gsbVAbS3iqDFcSerIgpBnAOAs7EVwBmVfB1g5kYCdloDBWREv85/oQlAjDKH0xwwzJdqW0W2j8qwNPnIPkmJDBbqjmk+SPmSpU1o0m6X0l6QcTA7PQmAH1gOML1ecT3kZ2qOL4lLaFfEtNJff2Tm02rBJwJ9pNlSLfwKuqRicq9LQ+UBeu8y7LIP2yw5YZ2LVRjZmiP5PrNL5ZV5YhUEK6Mfp1MLgn6/pDtpxXztBks7400jiMhgIGWMTopY0BYaQlPmr20gzbCimhEL98Yr0sTIBMy4fvJIrnbEr8QYwTq6ea3m0uxur4hUxmD5dgbV77BVN37LRTddhLeXJRONBicpPGRx9Qoe/DUQSGb+Pw345A6NXSt2SaWWmzcNmp31g2f+WB1uzkNHIHYJ0OcSX/sKz3xUq4rnaTiPtL1IlK+BJ5UGOE7FCJE7TYcWrKOBVbQueIww9XL+4xAssKTxMwgXPlIONrEm94DK8v0aoRqlmXVuOEPhoykcsdxyN37NPHa4yZAhIxFatf7sXdwORN7ibUX8uVabziUQtjf/IAHFh7DfJB2H5H7xAaiClhx9Q+25LlTEan4Gi5eBmp89cr6MJMkUUh6p7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(1800799009)(186009)(451199024)(2906002)(86362001)(31696002)(53546011)(6512007)(26005)(2616005)(478600001)(36756003)(6486002)(6506007)(71200400001)(38100700002)(38070700005)(82960400001)(122000001)(41300700001)(31686004)(8936002)(4326008)(8676002)(5660300002)(66446008)(66476007)(64756008)(66556008)(54906003)(66946007)(76116006)(316002)(91956017)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjhpTHdkaEJRSHAvbDY5dktud0VBZC9DWWpOenNuTE5lYU1UMDR0Mm5yUGlp?=
 =?utf-8?B?QmNpMjV2UHF4bnpLanFZWCt3SnIveHlmS1hRYzNNRmd2cjBQVWRYOE5NOTNo?=
 =?utf-8?B?b0Z1RkZEdXk1aXhDSlFNaXVVRjA3a3VYUS9CVWUrK3VxbWpFYVVmNjN0QnpR?=
 =?utf-8?B?UU5GL1hBOHFoWVdqZmdDcDBudFIzbm0raDhVenovaFpUWjh0M2pTanZ5ZUtx?=
 =?utf-8?B?eHdJQ1kwazhjN1RDTTRmc0FsazdVSFlQLy9VRE1PaUtHZmUyNXpKYml1K2xW?=
 =?utf-8?B?RDlNTHpIZ2hPcWxrUDdqdDBWTXg5alp5Nnp2MHR3S1VPT0w1T0taN3hoeVZL?=
 =?utf-8?B?bjFRYzIyZm9VNnRCS25Wd2tQUWp2WHVYY0NpTUFKUldqeVRVdFhBYTYrV1RF?=
 =?utf-8?B?b25TdFBYcWU5b05EY3dweE9jOHRZbDNRRENxMGVZNUt4TnZvcDg0U2d1WWU0?=
 =?utf-8?B?em8yMjB6VzRxQktWL2JncTJlYnZiY3RUdDUyOU1lR1MrVUlzNGhObm1NR29W?=
 =?utf-8?B?R3A5L3NDSHY4bUxJSmhRM2FsQUFYcUxSOWlhdENyVG1RS09jVSttQlBzeHYz?=
 =?utf-8?B?ejZTdVdrUnd0eFBxdkFhS3MzWVpqRHdKbEt0NkJSanpjdkFLS25TQ251RWVY?=
 =?utf-8?B?bmlnRjVIUFd3bzdEZXdqS1pjenpsaWR2TnpqSWludmdETXIxRTdCZmQ0Ymlt?=
 =?utf-8?B?aFhDVW1FL3FnY0xXcldoM3NyM3Z4eU5SaTYwVWhmVHFHQzZNYkxmZnRnOHRu?=
 =?utf-8?B?d3hlTGVJb0JaVVk4VGhucDROQTJjUTF4TzRBYUo4NnpKaGRPZUxWenBJM0pt?=
 =?utf-8?B?WGFRalR4K2lEaGRpTW1uNkQ1SXhQNGZRZENSZmZtSVZueXZIY0NnVi9pZkZ2?=
 =?utf-8?B?Q09uNzM5T2FkYkpvencrcGc0RGZONEpmTkVRS3F3MFB5VVpGVkxGN0dXS3Iy?=
 =?utf-8?B?UE1UaXcvZkpSd2orTkVPNDljaXZ3SEtzSndCMnVyM0J2MDArdnU2ZEc4b3Ix?=
 =?utf-8?B?eGxSN2p2TUZVWi9mUTZRYm1nQndCT3Vyd0VRaFZ0SWh0WFZuTEV1dFhyeXVx?=
 =?utf-8?B?VzhoeTNXY05jMFlUK2ZkUXJYUk1ydzEwUklzV2NidUJGeWhHNDF4Z3A4cTlo?=
 =?utf-8?B?czZVUUg2a0ZLTzF1ODZVcW13RUJhTGpSRm1qc01RTE0xcnFmUkk2STlMR0cr?=
 =?utf-8?B?VEo1R0Fhc01SWTJxQjlVK2wycnFya2wwRWR5cE9sTlVxM0NzTVhNUVNrVjJR?=
 =?utf-8?B?VzlNZTRtL3NJdVIyUjhqejlvb3J0aEpSbmhacGN1NXhPdlptTSszQUNmSi9i?=
 =?utf-8?B?cEFKeG55U2ZYdkxlOThkYUVwcU4ydkVzdEt6MHFtbUVtRUpoOEkwaVh4R0RC?=
 =?utf-8?B?VnZQZDU5TXJEa1pwWkgzUkxPWTM5cmVZOE1iM1BFQ01rVWVrS0l2U3FHcDZP?=
 =?utf-8?B?Qk1FeGNuWGFWZUF0TUkvNk15OWdyWDZEeEpQMkp6bXRublErV2NXNFJrQmJE?=
 =?utf-8?B?M2szUWhEUi9XSERETE5kL090a2FtcVZrcHZiNkl6eXR3M2FsbFRibDZOTm8v?=
 =?utf-8?B?WThBSXhaY0VJNEEvT2syZ2JlWkRTS0syMmhxMU1PM2lHM0tVS0RwNHRLUjI2?=
 =?utf-8?B?TkF5R01ESWsydVlrTkU2VHRyREQ4akM3cDhFZXErOTg3WkhVNkIvaHEvcXlP?=
 =?utf-8?B?SDZnRy9XWXA4ek1heENZZ1NTTmNRZW94akxuYk5OS3k0Q0p2bmQyZ0NRMWQr?=
 =?utf-8?B?dkRmRVhoa3BEd3hKVXpucG9TRTk0S0JodWM3NGFwYThSVkRlSHMzcUJ1Mk5F?=
 =?utf-8?B?NEgwY2JqUjlDVEd5alBheDNGdWVOZ3BGenN3dUdvYjdMNC91K0xCZ0xrT2RI?=
 =?utf-8?B?MDAxT21CTXpKWUZUOUxHRWVtNzIyZmgvazllZEUydktxb1lVaG1rcVhhM1pu?=
 =?utf-8?B?amwvS0gvSFFDa1RxckFiQ3VGbW9TU1l3WGFOV0lVckZ4V3hieG00cE9QenVK?=
 =?utf-8?B?SEZuUFh3cFVlL2U1WEF0VmJ3UzB0WXYwT1NHaUd5VlJwL1R3WFhxc2ptYUxa?=
 =?utf-8?B?QmN5Q2trYm84c2hCL2RFejF1bjhxc3oyRTUrdlMvZkhiczBIeXhrNTdqb0tX?=
 =?utf-8?B?TWxuRGNJM0FwMVJlbG5MRC9BdmxnTDJGb1pmbHA0UGh1SnpCYldPb0pvQkRY?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A81309EA9AAB504A9EDE397C0E5BF9B8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZmxkS3Z4azZUQmVHQVAzNmNoUE91N2wrOHVuL0MxOE1FaUdrbnFIUU1zUzJM?=
 =?utf-8?B?LzNWWW9XNUk4VTFGVmFHSGVRMGJhY1QxVmx3dW4yZVdTZGJZNVNmYTB2KzNM?=
 =?utf-8?B?aVNjYk5wMHd1TDNqdDFLdlNSQUFWN0plVExPK0NpMTBrNktobnB2VHc0dDR3?=
 =?utf-8?B?MVQxdDdnSlVRZFNNMitsZnJNcDMwcjVLWU1raUlUY1g1RGZYUTlWMGRkRHNX?=
 =?utf-8?B?a3BGcGNNaUUzWTMvRlB6R3piUFJBeXV3dG5BbkYybXI5d1Y4TVJzR0tyNVlM?=
 =?utf-8?B?S0JrK3lsUFh2L3ZUbmdvNDQwdFdwckE0cE5GVWhsdk1SS1d1K2JNMEtZL21m?=
 =?utf-8?B?ZDVIYUFRZEhzZFY4eEpiemtKc3FCSncyVTFpU0JGV1AvMW16R3ZMVUxFMkli?=
 =?utf-8?B?UmZIQnd1dU5UTlpEcGpuRTZvR1RYdXRTenN3dDdiOTdmWVZ6RlZncXQvcVB0?=
 =?utf-8?B?emx0L1lkanlKaU15OXBUY3d6aWltWUJ0WlZLR0UwRGNaem1UZ1RuMFhiRnBS?=
 =?utf-8?B?RklKbzZmZkNyb2NzRnBBVE91Snh4YWh6NGhVWUZzN2VJa3VLb215dnB6Ty9j?=
 =?utf-8?B?ZWkvYWlVT05sNlQxc3NTemN0dUQ0c1Z0UjJ0MjVaS1lybHkzNHZmNC9nS095?=
 =?utf-8?B?UW9OSUh3QnFhQ3U4SHFLNTRPVHJTeDM1UjBPclllRW5BMHBIeDhPMG44Znhs?=
 =?utf-8?B?Vmd6c1FWUjZKdlBsdVoyS3Q4bkdhalhxTS9xZUZwaGVBRTNMV0ZpVjR1ZjUw?=
 =?utf-8?B?V24wdVFDM00xajVrd0Zrd1VPUktpYkNIaVN3UGVBQ0p5UUFUYjBpeWNpYURD?=
 =?utf-8?B?UE5rbzdYMU95Nmo3eUZTdHpsdStPYmhvcHl6YmU5ZTFvbUllWFl1bVUvbjg5?=
 =?utf-8?B?SlNZNncvRDdtdnpHN1pzMWFpUVlCOXJjaXZCcUxxSXhwNDN6YWVmQlZXZjAv?=
 =?utf-8?B?VGY1V0s4Yyt4cW4yWDF4SXZCTGhpYUQ4Nk5Ha3V1THlwc2JGa0J1ZXpMVCtl?=
 =?utf-8?B?ckwxL0pEV1ZWYzhCZjBrWks5NFNzUmhGaGdXdDZhY1dXNVYwbGxqR2tLVnBN?=
 =?utf-8?B?cHlCSEFOL0pndW5pdFNNUDhNZ2k2RkpqWnlVWnNrOXh3SkhOMTJ2WTdrZmF0?=
 =?utf-8?B?R0tXNDdRQW9ZYWJvMklxU0dYUW9pRE1xUWNMNzNIU2V4SDZkWk9RNkN2WFR1?=
 =?utf-8?B?K0pzSXVnWm1DNFdYQlpNcERWSHNMYTB0L0QvRTBsMWl5bVk3MGpySXl1RHo3?=
 =?utf-8?Q?7SRRj6RfHdPKr1D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 462c4537-ce9b-4d4e-9812-08dbb53829ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 15:35:02.8531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jv428GbxpDkCjM8q34X16sX6zbgV4QFyo62KUiypyiUAzAIixRN+KwCJmsPnDiXhSCih5A27Ngaz+TRzXNH2krkyqgUrm+pJk/dH7gJ+x5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8087
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTQuMDkuMjMgMTI6MDcsIFF1IFdlbnJ1byB3cm90ZToNCj4+Pj4gKwlyZXQgPSBidHJmc19p
bnNlcnRfaXRlbSh0cmFucywgc3RyaXBlX3Jvb3QsICZzdHJpcGVfa2V5LCBzdHJpcGVfZXh0ZW50
LA0KPj4+PiArCQkJCWl0ZW1fc2l6ZSk7DQo+Pj4NCj4+PiBIYXZlIHlvdSB0ZXN0ZWQgaW4gbmVh
ci1yZWFsLXdvcmxkIG9uIGhvdyBjb250aW5vdXMgdGhlIFJTVCBpdGVtcyBjb3VsZA0KPj4+IGJl
IGZvciBSQUlEMC9SQUlEMTA/DQo+Pj4NCj4+PiBNeSBjb25jZXJuIGhlcmUgaXMsIHdlIG1heSB3
YW50IHRvIHRyeSBvdXIgYmVzdCB0byByZWR1Y2UgdGhlIHNpemUgb2YNCj4+PiBSU1QsIGR1ZSB0
byB0aGUgNjRLIEJUUkZTX1NUUklQRV9MRU4uDQo+Pj4NCj4+DQo+PiBUaGVyZSBhcmUgdHdvIHRo
aW5ncyBJIGNhbiBkbyBmb3IgaXQuIEZpcnN0IGlzIHRyeWluZyB0byBtZXJnZSBjb250aWd1dXMN
Cj4+IFJTVCBpdGVtcw0KPiANCj4gVGhpcyBpcyBtdWNoIGVhc2llciwgYXMgdGhlIFJTVCBsb29r
dXAgY29kZSBpcyBhbHJlYWR5IHRha2luZyB0aGUgbGVuZ3RoDQo+IGludG8gY29uc2lkZXJhdGlv
biwgdGh1cyBvbmx5IHRoZSBhZGQgcGF0aCBuZWVkIHNvbWUgd29yay4NCj4gDQo+IEFsdGhvdWdo
IEknbSBub3Qgc3VyZSBob3cgZWZmZWN0aXZlIGl0IHdvdWxkIGJlIGluIHJlYWwgd29ybGQuDQo+
IEFzIGlmIHRoZSBtZXJnZSByYXRlIGlzIG9ubHkgNSUsIHRoZW4gaXQgYmFyZWx5IG1ha2VzIGEg
ZGlmZmVyZW5jZS4NCj4gDQoNCkkgdGhpbmsgdGhpcyB3aWxsIGJlIHZlcnkgbXVjaCB3b3JrbG9h
ZCBkZXBlbmRlbnQuIEFsc28ganVzdCBoYXZpbmcgDQpsb2dpY2FsbHkgY29udGlndW91cyBlbnRy
aWVzIGRvZXNuJ3QgaGVscCBtdWNoLiBBbGwgdGhlIHBoeXNpY2FsIHN0cmlkZXMgDQpoYXZlIHRv
IGJlIGNvbnRpZ3VvdXMgYXMgd2VsbC4NCg0KPiBNYXliZSB5b3UgZG9uJ3QgbmVlZCB0byBpbXBs
ZW1lbnQgYSBmdWxsIG1lcmdlIGluIHRoaXMgdmVyc2lvbiwgYnV0IGp1c3QNCj4gZG8gc29tZSB0
cmFjZSBldmVudHMgdG8gc2VlIHRoZSBtZXJnZSByYXRlPw0KPiANCj4+IGFuZCBzZWNvbmQgbWFr
ZSBCVFJGU19TVFJJUEVfTEVOIGEgbWtmcyB0aW1lIGNvbnN0YW50IGluc3RlYWQNCj4+IG9mIGEg
Y29tcGlsZSB0aW1lIGNvbnN0YW50Lg0KPiANCj4gUGxlYXNlIGJlIHZlcnkgY2FyZWZ1bCBhYm91
dCB0aGlzLCB3ZSBoYXZlIHF1aXRlIHNvbWUgYml0bWFwIHJlbHlpbmcgb24NCj4gdGhpcy4gKElJ
UkMgUkFJRDU2IGFuZCBzY3J1YikNCj4gDQo+IEN1cnJlbnRseSB1bnNpZ25lZCBsb25nIGNhbiBv
bmx5IHN1cHBvcnQgdXAgdG8gNjQgYml0cywgdGh1cyB0aGUgbWF4aW11bQ0KPiBzdHJpcGUgbGVu
Z3RoIHdvdWxkIGJlIDI1NkssIGJ1dCBJJ20gcHJldHR5IHN1cmUgdGhlcmUgd291bGQgYmUgb3Ro
ZXINCj4gaGlkZGVuIHRyYXBzIHNvbWV3aGVyZSBlbHNlLg0KPiANCg0KWWVhaCwgdGhpcyB3aWxs
IGJlIChib3RoKSBhIGxvbmdlciB0ZXJtIHJlc2VhcmNoIHByb2plY3QgYXMgd2VsbC4gUkFJRDU2
IA0KaGFzIHByaW9yaXR5LiBUaGVuIEVyYXN1cmUgQ29kaW5nLg0KDQo=
