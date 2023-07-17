Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240B1755CDF
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jul 2023 09:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjGQH3P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jul 2023 03:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjGQH3O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jul 2023 03:29:14 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D18DF7;
        Mon, 17 Jul 2023 00:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689578953; x=1721114953;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=Vx00d5TTV/Vv0n0/z8/4srzCqYgrL2a8rESZxL/ll3147afKZDcrX/hX
   jaPBOFjz1UnVLX14JJ1UVWt4/+DUxj0ws4ymywBu0aV/sgrf+iJFe3jqA
   24XYXlfAOI7HFcZJIE2G/DFYhXa0zHEY6kZ89lr8fjKrrSEV+PKhK9hiO
   1ue4Ge0eSHD+aNi6MgRKyxrdXRq7jFJ5K390PD8jGpzYnlVJXj5qLrcF0
   650pOVCYktYtKqBau/nCPhB3EP0ylpe01LHhp/4BZQwtaMBqAH9uwk7AO
   FDADpvj2pfn+mVHnt+FgLjqd1rLpA7ZWUn6nQYTVMnUjZUzjJz75Cl9U7
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,211,1684771200"; 
   d="scan'208";a="236609914"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2023 15:29:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSP36Kd81l7feTCJfsR1iSB6ka9u/X7um2Tp4mCXksBGoZySRQ+zYconkSEtmcQJ5CvJx4dv/7AJfNHw1VNcUaU74NheY5ro92CcX7P38/m6dNyoxftQm/pX4nkhMp7wGe+k8Xg+r9Qtux+ncwC2w87wzEg2b2i9DqS+rpKopaM4fiUJ7BsvWvYTDuwb7itruOcidYLgLutHZob6z/jnYe/IpJFKY5Vr/Es/QmJkGqgkPwZFwAxLrTZoe+XrufKtPJZd/YfhIOzT60+6wAzEDs/9hcf+xg1noqm+Dq9QNDq/i6uSUvWxPSTlRE60z65zEJWqvoCqW4zXFbzN+EDS6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Rblg/2ozSWR8cYKRsWL0tUZh6JXxqk2riHZHHhwvVQ6qLaGRL8ZmzfpabGVMereXQeav9/2HtBU9EBWWT0v9XUL8NS0owhTR/OyLClvs0PcL/E48qseAtOIRbZS7SoFWLSvXgWYdyV9KOxSmF+LprkdaT/gz7/pXDBPVG2y1Hxic4D2vL0zdOk7p2580wiChJHRwlfke6R9vh4ZEg+yOUSWrFk7L9ienhu4mtzVLxP2Lwa6UKuyf7MDtGvmtjBOy63tNlcxU6u7LEG3+1lPlQ8Uj4BhgGvIkpVHffC+5AmhPen04VLqUvPQ0KfcONCEa9e9xoUrZUUBZlB4Qwxph8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=QM7HjSwbydEAyghCCor93LIpyl7rp0Kk8DzwDqN0KxaCwFzy0OkcD7WdF3q15hCw68Gmf3UKTMoZEpoC9PUDz0jzepouTbOWMqKFoI83kP1lJlxrnJJtp/0jf7mLZ20K5CWgiEUrc8dyCAbE73aHIKEIfKpgZwAmHIBVO7mAkDw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB7131.namprd04.prod.outlook.com (2603:10b6:5:246::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 07:29:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::64cc:161:b43c:a656]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::64cc:161:b43c:a656%3]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 07:29:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Minjie Du <duminjie@vivo.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: Re: [PATCH v1] btrfs: increase usage of folio_next_index() helper
Thread-Topic: [PATCH v1] btrfs: increase usage of folio_next_index() helper
Thread-Index: AQHZuH6kfsiDUO87kkOU71Iqp+c7Jq+9j8KA
Date:   Mon, 17 Jul 2023 07:29:09 +0000
Message-ID: <09ad482c-e53d-85d8-7372-59177c8324dc@wdc.com>
References: <20230717071622.5992-1-duminjie@vivo.com>
In-Reply-To: <20230717071622.5992-1-duminjie@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB7131:EE_
x-ms-office365-filtering-correlation-id: 0a929603-fb75-4a88-7298-08db869782eb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dbXFgedN+7z551gvR05TFX5XLgyWnpvwh/yDNtu2lvqAWYIVySVGIAvc9lV1F2jDyg17L3PTP33tAzAM+G645KE9/MbOIPvM8mIxLJLYF2HK9dK5MKs9RxODPmWnKnltd5qMorKvEbn11XUxrp7nDDu2OqBlqvmaA3ySPVDFwwg0c6U7TFRu7V913yeq1ARO8STV0v1f88CkNpCH/q1EFb9jxjn6mmFYe+I76OSrVtafYSc73UOLOiJkMRH8YJHeeH66YPP0zpVAgnzdxeNgaLEGlsIWgQgQK8AQ8Dw074A/te12GoUoyjZJcrGXzRtO00bjTAU0rXOAKEc9scyL7XacKPPOdfY9QkM3DFRM/lZbucUUST3v+Q0m+PfMrIJa7bAxwuDIz3oz3s8J7w6G6xdXFquJml1SyTtbLD8vnmAFkyyqLR8e3NS5ZJlDp9TIJ8XYoi/kThyHSSp9r1OWOd0KpctT5XuLaxeZvmE1ZTWX0Hza7O/Tzzf3/WtNL7TIkc9cHvpsITAMjoxLAzj8tEQPe/CmNj0qsVyANzpybBOXinXYV842PfKeEoic4cF9H7MlMy5xqtAr9+Id0fCONYoDrsmIB7hufPzLk5GFeMYbGWGoGAdPwFAJvF9e94VReHdO1T/F6rMGB31fg404iySnD1IVDusu5Dw+5wbsS6OtSHmfyk0/GoqXBWfTjOC2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199021)(91956017)(478600001)(66556008)(66446008)(64756008)(66476007)(66946007)(5660300002)(4326008)(76116006)(316002)(8676002)(8936002)(2906002)(41300700001)(19618925003)(71200400001)(31686004)(110136005)(6512007)(6506007)(6486002)(82960400001)(38100700002)(186003)(4270600006)(2616005)(36756003)(122000001)(38070700005)(86362001)(31696002)(558084003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkNLVUdYcWc4RSt1L1B4bHdkaGRvTEI4dnNSSWd1WE9XeDVsellZVFZ3MkhV?=
 =?utf-8?B?cFQwSWI1N01wVzJoZWVva1dNYjc2UFlrb3JZTHA5U1M1N2tVUzFsY1FHVGxH?=
 =?utf-8?B?dnpBSW0wblYrVDl1aXIyemJRdXhtcEdGVFRzTHRDckdpNDNubzY0MXZNdjVx?=
 =?utf-8?B?eHNlQ0tBM1p0bjlXSldsZ254dlF1bnBFRWRva1g4WDZKMmJ5a3NGbnprMlBh?=
 =?utf-8?B?REtUY1A2eU1RZ3pnZGlvUWp0MmRMcGZBWmRjRU44TzNSSmVRTG5CUE9maDNE?=
 =?utf-8?B?Y2E0cHJTVVA5U0RuNjk4YU1FY1h6dkgyK2RFcU9LV1Z6ZTdUMDd4VTZqWWE1?=
 =?utf-8?B?YjErTjdpN2FCWC9RVkc1dys5R0FqOFVrL1dnOGtVYUdGZmc1dTE2dXNMQTgz?=
 =?utf-8?B?THZKOVVHcmwzUUZQYzZ2UUJPUHNVOTdmbjRMajRpb3JZT2VXYTBSckwydE81?=
 =?utf-8?B?OUp6YVl4djlYWHRSSS9UVlFwQzUzM2tpK1pwaHZBZ0kzRDNZa1VLUFlYOHd0?=
 =?utf-8?B?ZU5ZSDVmQnhmbG5mV3BPWTNtUXMxLzExSlN0ZllOejFTSjJSS01nRFZRK2Uv?=
 =?utf-8?B?WWNJSVFtaXVzUXhYREVWT0k1MkNWNy90UlIyUHFqaS9WQnk2QUZPaE40aU5Y?=
 =?utf-8?B?c1ljZkhnYjFINStSSHlBOUtSWkswcTZ1VlhOVkZBc3BmVmZjY0wyaXZlcXNs?=
 =?utf-8?B?YW9sWi92WitiSWlIbk5SREMyYUZLTDlwdTU4bnJmd0Fyb3JDUzJDcFFhT3dz?=
 =?utf-8?B?ajRlWlVqK2lvWmFSNkNtSWJ2TlczQk9GSnFZOVdwNUJIa2hxcW1aUWZHaVBL?=
 =?utf-8?B?a0VmN245NzNMb0hmd2NzVzZ6YllqWU05QkR5U3Z0Nm1GTTlFbS83a25MeENB?=
 =?utf-8?B?UzkrY1BFN01LMzVOcmFXOHVlc1hnV2o0OFF6SkEvWHhRdUw5WmlLTWZNNGJs?=
 =?utf-8?B?M0xucWVuR1AzODlZYlhCRXEvU2tNVSs5QUV1a1VucGlkaVNSNHRCTXdRb1pl?=
 =?utf-8?B?UmtFRFFVTHpOeGFzOGF5TC9Vc3F1Sm5hQmljYzEvVkJGOUdOL3g2aSt0M0Jl?=
 =?utf-8?B?THUyaDRoMmFpREtaKzVVZ0tNM3VOZllEQzJnNnBING5QMkM1bEZiRmFaVTVS?=
 =?utf-8?B?eDl0OXFPL2dyOWloWkpQRmJwWkNuMHNValB1TEZBWUVVRnZCU0ZLdWFLRUtV?=
 =?utf-8?B?dmhFU2dFYVVpOURUU0tpaHpvNUdJR2tIeEF1T3dTWWRPMDR4d0RKeWRMQ0xi?=
 =?utf-8?B?V0o1T01UK2FweE9mTGU3VlJ2UG9HMXZtOGdXU1lhSGFNVVQyVXVycEJ5Sng2?=
 =?utf-8?B?elhZUlhjajJzNnNBU1dIdUlMWkpWZ3VualplcGZ0MTE1Nk91Q2tQL1hXRC8v?=
 =?utf-8?B?Ums3bUxKekRlL1Z1QWRzdDViZlB4U1k5M2ZjdzEwaVZ2ajFZMk91Qi9xSTRp?=
 =?utf-8?B?d081T2xkY3krVUxUVFphNnNoOXR1WmMxNS9odnNuM1lIdzZUa2pGMTRURTh0?=
 =?utf-8?B?c3QyNjJpc0piNjY0VlRjUVBJMy9BOVlTc0o1cldyYlptS1JZdFdZcXZCVjg1?=
 =?utf-8?B?UUx5a0hVTmFoSjhKemJXQ3FHVityMXlsaW9tTjh5TndscTY0WW1OR1FWYmZi?=
 =?utf-8?B?WGNQYzU3VFBiYVh4ellMRVk2SEtTTHdpL2JhcDBQbzVDcnBsclJBdUwzVC9K?=
 =?utf-8?B?RHRpQnoxWFYydTFacTYrYXhrejFGUk5IZjBtNi83eEZxM0w3Rk90MkVzODJ6?=
 =?utf-8?B?Ty9NWjBMSy8yM2xMTHExMDZzV0ZXNUNGdFh5MHAwY0RzZTNVNm94b3NGaktq?=
 =?utf-8?B?WG1mTmlqWSt4bGdOMmhVNldNOGRjZEFFcWpHZDhjSTlSenRicVl0MWdMNDBS?=
 =?utf-8?B?NEl4eWNHVktRSG1raXdwVlA1N203TTYxRlhmdzA5S3BiWWZwM3hpODMvaWF1?=
 =?utf-8?B?WXphWlBYUU9tYXg1UlNJNndadENCMWRlV2o0N00waHFtVGhoaUZPbGp6dFB3?=
 =?utf-8?B?NjYrWE1NMWdVNS9KQkFGQjJyZUIvK08zcU9nbmdBMWo3TkFmTzQxSnQ3Vlda?=
 =?utf-8?B?SFBSbUYrSXkvT1Z0SDBlQVBja1NndTBiNTNQQ1RaRng0bVRRa1N6VnZzYXd1?=
 =?utf-8?B?c0JTQW1PUU55UVJOb1VCbzUvNnhBNDlPS2hoK01pZjRZM0Jwc1kva2doUjk0?=
 =?utf-8?B?bjJ0NXdGN0g5RW5kRGhJUHFiampJZDJZMU85NG1RTXFWb2F4RzhPcXlUbzd2?=
 =?utf-8?B?UlpmbmQvSFNGUnd6TE96bUg5dWFBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1FE81FF158DE0C4FA0D107DBB3803E4A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OtD+ZjZi1yUTZbGAzIlRxXsUFMPCo2X2ivYSXaaWUs6lJMnvRZjwlkpuTN5N9AywLB/683VBN2C1zZ3/HkFgl34lSJHKMPgO4CtK0PjTMNJlPAgh0dS/jOw0ZG9IZPfIhKSm9paeYaH9yE95ZVyUuDiyp64OgTdtXw9ttYJTmyGG4ZcroMYNBpn23JP2JXHC1McplwZA6+BZb15EPXi0RA6JyXoneJYvCi4+gcJzrJKs2Ro4ImWlYw3oGl+vvCZIdf6zHn7bMeR80E4JGbFaWpHLWZjnANG9pYJx2e/Q3JSCmvf1nNyimhli8G5zxLOzL2kjBMJu4FIuuBPkNL812DqsHSHLNycYFcMNDbNaX4nfKJILBEgAoFo1k+3TbUokGc3eptTTXxMKHz4I/1CetLRX/EtbO6vrxC7XqezhN8XBgp/qjMNLEFr7Pz04Csb85wr8khdP9cGIW/W+B5yyS6tip77hN48aP5UsPSk6vaVOtgFO82m+Aw78zZLRnFi7wd9H1n3ceJA9pi4EbaY7epU3lLGOXwtZz7Qcl3Ib8NQbEiKBa28r1/AxOPkEHAGJjSVuZTat1L3yZGyxwCVOSTbqvR5VpSQWdz0irugI2ITKDugJQPQa477+3ldl526uCmGFckEuDZn+WgofmMJHoR4skJPHORrZGHpkLru4B7lpOMf6a0x8LTQmG1bjfQdakdECsYE3n4HqBLdYBwxfGHvWib4RdiffRvOA+bI7fLXHZJ/EVNQuxHhYjlzHfSWU7rSH32eeH64avssBq5BMm/Z2g8ABPgtRNdKxzUtHcvWLWBSdyMOZA2k3uaSJWbTgjQDtYwJWj+LEz30YdsJgu50r54iI2LC9DX0sw2VpHrJcO3BuPvTrjR60fObD7Hsb
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a929603-fb75-4a88-7298-08db869782eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 07:29:09.7700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QD43oR9eWoULL7H/pkmcizLT8l//dQqQgjdC9dHdo87YYZ5LAV5FHGB6U3GpyxACVas3CIbfTBeBcG8WGJZL0rzHK9Z+PzSVgq40o9kHgbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7131
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
