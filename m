Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D1C6FCA8B
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 17:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbjEIPu1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 11:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbjEIPu0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 11:50:26 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216D03594
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 08:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683647424; x=1715183424;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=GdQn9HzL/inrDLC90pnxf0J3AcAKnOggn6bATq/nUiJyoWN1DJsMqzfq
   qPECFhU6hhUoUre5yKos+uxTYByp62jNQKxKEnmJwtuwIZxmcNPUQTCka
   fnXIVGefRcfm0CtZUV+oFpydXzeTirzLcFKGgrQVHeImUxZkWJfclBSU+
   TVZLYQrfp/1bLAXqYib4iOMCErLgGluHMifN7BfewjrUgXa5yf+m24sFO
   AAdR2Ckh6VBK+uP5WqLmu5jj+SI0Vnu5qxIH/UOzkq4sizZa4CY2vytBv
   /3YrhNTkhCP5jy1IYJcj30M+kTInC9LIaL6qPm3Bh25weJfR12OGabsjT
   A==;
X-IronPort-AV: E=Sophos;i="5.99,262,1677513600"; 
   d="scan'208";a="228444085"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2023 23:50:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajuYol/SuqYaMmt/nVgOmBQzo/im1vavqD1VoA0E9H2coSRNKrwhZljP/Ws2uGf+/fiZ+oLnDP5IG2WI1ZRR4l+8B5I9MxZFSc1owTKJRTZJQxGIOsN1H9mgtPwJoEzmkIBQ4roWs+kNweqO92VYcFFq7tpWlXOYWux1eTrm72DlPeNe/QsAATB76ZH2gs7HSttLTyMktdYM061IBcLLmq8xwy1rDkMbfqD2DZbae6u5en/TBr7aViAXCSvcFC3WsQAUE3fn/wp5MMfcW50zYvlpfJsri7RgfJDgcabm/PLKvuyEe48AqtTKVkJwgAtqqZa1VAKdtcF1EZOWfKBllA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=bk/ymdmlwsxX7swgS9QZJ5P7tE88xKsNC5OCH2FSai2dqkaQVvFWg3ber53ptEHb98dXgeWbleUTOLOn0GHWEG2mDuX0+JIu5w3o+MgpZW0MVfxX2bi7DpKocT+pNXjA7+Pje1Za3IYEUEsJ2mbMYlF/hZR5OYbweVRbrVjL4VHsT2wVhxdprS5U0oHXCkZU1kTuN1ijvqxFmj9dN2IkSfxDVNfhj6WqoMCB2+ovPExEev+olprArlIb/WU1gP3vjvNXN6MkzvqYHSx5R7tuBiipWHjBDWpBgCikMnjRYrLi7lX3jdxvzkH/zo0jjLhFbZFYWTZ7jjsxzR4JRWMc2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=PNNx/nTwlAcTH22RP9R0B2u/YB3kb8AKU7qR+tLKHSmaULIJImc+IEFlo9sTrxGvspaVQ7HwMX5A1K8UhTa4nE4BHYYAcUmXf5syYwMCcI8MTWbKj2XUnUv3IaB4tWux9F4T2YeHECIcg8EqcUqUmAlR+stQm3BC8QI4p30pwuE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6792.namprd04.prod.outlook.com (2603:10b6:610:93::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 15:50:21 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 15:50:21 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 19/21] btrfs: use btrfs_finish_ordered_extent to complete
 direct writes
Thread-Topic: [PATCH 19/21] btrfs: use btrfs_finish_ordered_extent to complete
 direct writes
Thread-Index: AQHZgceJvPwKD+1U9kS3l9oRdKFwCq9SGFsA
Date:   Tue, 9 May 2023 15:50:20 +0000
Message-ID: <141c30ff-4a8d-ac20-1f13-7e844f8dfd52@wdc.com>
References: <20230508160843.133013-1-hch@lst.de>
 <20230508160843.133013-20-hch@lst.de>
In-Reply-To: <20230508160843.133013-20-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6792:EE_
x-ms-office365-filtering-correlation-id: 4efb3ad8-4495-4832-0851-08db50a51847
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aQFl2q1Gi/4OuMzY8yBxSZS2yLQx+93nrdkJBm21Kpeuc4xyD4UCc5zDjaY4f7Ty+u0vqoWouNmohbAIbHy06rekelbdSrzFdNpCtToYPrbkMjuD/fGL3WV163aYvwDyUUc+osYig5AouoYcfLMxlhhjOxzjG17FV27KcHyQA2CFkBUfBFKuSTVRG0hyZ8HbjjdtzqmJbGikGTiX4e9+V+WK5YGvtYRG3A/lkEV3nlN3hdfFbi0yKbBClmfwAE71qann2eQDNVsda8I8gerZpDCSXtgrKbyNdJC2R3rayKXmVqULz3FN5aWVMAQF7/tv56cRngiU+YNrjyZMOmobITagWrDV1WJrsZ6tQJPrJDrXkaQl+1zUCdP4FIS4mHl2o0zoBQg2abwI7fP8cZrpdjYCVZaSbt3EwrQ3/nSCP1zHp1pa13SaM/MATSPL47Nghae5f6wSp69moH8j0/dHH3jFKeKtudnoxyW6cQDA3GYpbXBopwGeIKdqA3gY5/EgZh+nFC1O3yiYnLfM/IlbGd+5ZTAODT95QHYO22JbO3RwavcQN1t5c/COGrvvUYCkGqcuYG3m2kwNwCC0+eHi22VrlFj2f+c+Ab2DJ0B9GrciXGQodRlo/Om0z7cv+p8IkGUSFaIzrzvFbuvyBGld6jMOjBVm0PowPgoDFzQbmv4aGs+mkHEsghvg4xOfkgoJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199021)(2616005)(186003)(4270600006)(2906002)(19618925003)(36756003)(38100700002)(558084003)(38070700005)(31696002)(86362001)(82960400001)(122000001)(6486002)(8936002)(8676002)(316002)(71200400001)(41300700001)(5660300002)(31686004)(110136005)(478600001)(66946007)(76116006)(4326008)(66556008)(66476007)(66446008)(64756008)(6512007)(6506007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amJSRGQ1aVk3aUpocjk1SG1vbW1RTGNtTnRqQ2RSSTN2allGd2ZqVlpERUxw?=
 =?utf-8?B?ZVFVL3ZJOEVXRmlKeVM5LytPak1Vb2llTU9lYkxVMzVsQ0NDNnhyN2NpemtD?=
 =?utf-8?B?eWh0UkRoK1dSa2NVMGZaZHlVWXljdEVOU3ZPYmEzakk1ZDV4ME1WSDdodzdH?=
 =?utf-8?B?Z3BxbE9kY0dLcGRsNnc2OW03bXZaVFFvcVZoS214aUFyVmEzdGRTaUJaNDF6?=
 =?utf-8?B?NkJvRjVlRHk5WUFscHROd2RRcHFLUlBCcVVvWGlmZDFvcFhZY2dFdGVmbmZq?=
 =?utf-8?B?QkZsM0dWUU9yWDAram5rOHNFdkdUUWljWi9hT1ZjdDNyamdQckNDdDA5bHI1?=
 =?utf-8?B?UWdzRTh4L3ZtbEpKVE5ENjZFNWh2a25MWG4zSkFEdG5ZS04xUlFQMVNRbUdk?=
 =?utf-8?B?VWY4QytpeE45VUFUNkcvOE00SnNNOTQxcVBzdWlqdTQwcFRYOXdGdjQvTVRm?=
 =?utf-8?B?bFl1SVVDU216TEdmWnpMMkFuQm5zaGhGUjJOV2hyVmJJWkdROGd0bExLOEJG?=
 =?utf-8?B?WllnOEREZFRzNitiRXowUUZsK1d1WEN6cldUQVluK0U3UVNsRXhWenlZYXE1?=
 =?utf-8?B?MVZnK0ZNNGlyWGMvUVNjNWtVRzQ5T1lvNHhaNEQ0ZlRFTy82UnAxTXNmam0y?=
 =?utf-8?B?N2JBRS8zdGdGRy9nRC9pWmxVYTBlMnJESWJ5L1c5dGpHTW1TNlcyeVZyWFpE?=
 =?utf-8?B?WUlqMWZERzNOV1o2YU0rbEVQRkZ5aWNqVFJUQmkxSmRjU1owdXhDL3J2SWJQ?=
 =?utf-8?B?TGU3MG42SVJ1bllLM1drZUI3cHNDRTlnVVQzUXIveUVYWDErb1M3c3JjN3cv?=
 =?utf-8?B?OTJtaDY0VFRXblZhUjhTbCs3MWxLYXZUMlo0YVcwUDc5NkJzN253MGUzS0dv?=
 =?utf-8?B?elQxRVNZcjVzazFQK0Q0c3NlMmxCNXlrTTF6Qldmb0VaUmtlMk5Nc0duR3Vt?=
 =?utf-8?B?a243SG15VUdXYzFha1J2dmJiVWJycUpscFpoeUV6eU1NWVloUTUyZmFhTnBx?=
 =?utf-8?B?eXJ3VjIrVnBnemFQVStZYXRaRDNsWVhQc296Um5JYlFqdzdGQXJIRjdEMGk1?=
 =?utf-8?B?NURqUnhVcEc2bzJLc0tkcm9NZVMxY1hiclBjSFY2N015a3dtWVpFQ1hDODli?=
 =?utf-8?B?L0VvV0FCVmtpUGowYVM0WGFUU2NtREFVNXJOcmcrMnhxMFZIYlkySkVHb284?=
 =?utf-8?B?V01NRHltYlVaWGtKOFpuK1cyZnFqQWg1N3lPdWZvOCtsTldlWFNTbzhPQUY5?=
 =?utf-8?B?NXlCZCtRK1ZKcVh6V2U4TStEWkxJK2VsejFKcE9WWlpMMldtQ2VzRXBaMFpW?=
 =?utf-8?B?ajJ1K2xHQkthd3NKaWNWQ0JvbzZISFNjRnMwRFhWbENOaTFIVEFPNG8xbUc0?=
 =?utf-8?B?WG50dVhtNXVTTS9IY2wydXB1MW90YklhZkpSbGxJcHhWaFRIQytHVEhlN0da?=
 =?utf-8?B?bFpybERhTjBYeENCQ0hCOG92cTRrNURYand0aE5YclRJY3VzVzBxd0JZdlNL?=
 =?utf-8?B?VHhFb1VGWDB6QWY2KzFHM2ZmYUgzd25BRjA1akZRVi9lbDYreHZzZVR4K2NM?=
 =?utf-8?B?S0NIZUtNbHdrOXJybGxmdnFTU3EwSmxCRmoreFFiMjFTYTVzOUE5WUZacXJF?=
 =?utf-8?B?MVQ4YUMyZzNhcXk4NmcxY3BTSGNLMXBZU0R5Z3VVNFRDNU5Xa3NIaXdYUmxn?=
 =?utf-8?B?aXFvUGJBWDJqM0tQaTYxazZLR1NLOURCbmlDN1BFUVA2bFNDUjR3dlNGRWJa?=
 =?utf-8?B?MkFkQ0c2eFdtSDNwZ2VkaHI0cU1HV3hYZVMrb0hLbjVOcVhHQUdOakVUTS9X?=
 =?utf-8?B?RHFTSE0rZmdTdlNZYjRjbUlzbjRIaU1VZFZqZHo1c2FvbnlEYzRmcnpUWlJH?=
 =?utf-8?B?SC9LL0pBNkVxVWNNMHoydzFSNTd4VHVnZ3FqSEttRk9jaGpORXZZUnI1Vklk?=
 =?utf-8?B?YWhJaFVURG94SGExUzh3RWdSaFF4aVpvRmF2cWlOQjhCWUNBdThRUllhZU43?=
 =?utf-8?B?SEJpdzdIUTVPdjJtYm4rekwzVnkyOHFuQjR3bkY0aXA2aGpCdmQ5UmI0Z1l4?=
 =?utf-8?B?dXBHNkNmWU1WNnJxUE5OVWJRQUhEODFoN0F0aXlGMjV0T1k2bHVYOUVJNVRr?=
 =?utf-8?B?Z0pvaVREOWJ6emNpUWxxUTZFRkFrQlBuQzZvazJyY2VndENlRUpuUUYzZURo?=
 =?utf-8?B?N3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E13A0C5B0052E40801A523195D0FB09@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: G7TdzdpogYjq0xN8rqW1QTFVH/wUk9y4SashKU21urC6EvP3MeUCdegMHLUu9DwzaP1mKqiZ8vGnP3SPMGjReu1e+S9QgO3jcLFKxkVCAnJpBD2KVIcJImozVgbdK3cLGk9nGnUKycXx0OqkCOXU+dnwwcw8bw+Ou2JcueXsrAgcNG32UQu+PVRJYbQF3QLR/kUr3PxS1tfkL+bDh2Bjtyv8Img/lpetlMCGabIlEQTkWfhP+3zTrYYnrHXIYDYIyCX4SSLs6k8PdNc9cb2zrdiZFx8mZeom7IIYOqoQmhcFTNHELxMuRqXFd0rVZDZjnBqIUeCrnqTmRgPYTWDhJNEQmy/sZh7HFgEQedn8hu3LdxXwLJtLikGikYrGw7ZNtBQsx/ScncSNkcNo0WKAvN0p64zvCISE/4V3s8IcArdKCjkFVJIvWCsDRxBdFGah26AJ+yc+sQqZwv+o34ka3yvuLFFQ7Ap5pwWnblQSabdAE+BLSk7iKtmbmpXvUEh28YLyJilKdNaCcmpqg8Bhb4xwfZmYIs3Co8e45+FDW9/zvVhABSJmvvlNfh2j4c3mneg7peCfxVlIRrXc+5T3mrmDh5SkLUoRAAR/8cBrNYJYPER69ihHqPRMa2xhMrO/ziL3z2yG7SemEpTl25fDOHV8tYnLRV94klHex+zTpwkTfe0ZbthcESpUEiaIH0IegVA0nFmGinQPvdL9cheIqaP/E3i1ZjMPRE+pmViU6ml1BtoFHPS1qAGEOHpnyaeKMtIozX52EPyua6jngcRdsALtwka97IDDVQWLWZyCVawXyFY7A+XcFj8RLe/T6P2at9waL4fe7z4zb2F+AOJon3NAfg4jW/qOooM1bcYcYNKIlCyhZW99UhPsNUKd4Tq5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efb3ad8-4495-4832-0851-08db50a51847
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 15:50:20.9605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oOS1bUl3qbs+FooZGI4TdqRktM3atNjqjuNOBD/+npVXCVgUo9y73N5pyUNRvFT4Zg+EakgZFS4tfhFuy4qbhRcB54Su9kpoaWGWuqJ8eYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6792
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
