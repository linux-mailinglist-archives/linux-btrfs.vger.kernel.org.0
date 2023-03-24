Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9F76C8277
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 17:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjCXQgl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Mar 2023 12:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjCXQgc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Mar 2023 12:36:32 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABD21ADD8
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Mar 2023 09:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679675768; x=1711211768;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cianz6xrn8UCa7et5h0o/b9dpvApASZT/epOPoCSlfs=;
  b=SgrSSRrq4+HIhzFGoHkHQKphYba03Ie1fXG9xfAgpIsXJn1WEvC1IaPv
   UGgffzH6azbnJuotTGX9YMTle0shwew+ycYxXrPhYXQlNLRS7mh+/TD/c
   AhKfRWNSvqMZ9eGaDjQ8vQS36D7xV0r1eGkrKRYL/xSvO9h2uzxegf5OV
   nM6ZLN9+ySQxPkbILwHHoDHoGFn6vHb+5OMd7AxhGdj04PyKqE+iwLjmn
   a5euYjEzqkRT0uZXDHyLvTf493zCyMsPM+/3L/TjFmyIAwQr4kjLuuBti
   EqyFmjomFAASGqGTA7ZvqrYxgnz6KehpuRwwus/L7xyFC4Cpg3Ov+4xM3
   w==;
X-IronPort-AV: E=Sophos;i="5.98,288,1673884800"; 
   d="scan'208";a="224720555"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2023 00:36:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCCJwqhJnCv6L1S1wpVnwHWT2b7h3P2PVwo+tZfcm9Oh4X2oiau5YEx1yvfZIIIDouHwQR5g453LiKsWhsUmDm0uWrcaK7Snlt4tpjU87hte4D3Ba30V+F61OCcEIqIMslCITwpkkRQorifuUEmQVQ0/xHFRmOIOECQpmLTXYwIG73bBSFULHEz0+T6nw+s4BRozCB0EMvrfxW+0xxVaObDPOwdwt1RXZq/DizJidJxDvBzqv1jBJ3Xsv+WsSp166KsOH/i2a/JRSgjfQGc0zgFvIvLjsFxe5hjPjKCALfkcWWnTPNz/8o3K8bSNo4g47niehAO75Oc8DIxZMG2+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cianz6xrn8UCa7et5h0o/b9dpvApASZT/epOPoCSlfs=;
 b=D3F4vNfY/ogKCppvVpx8J1Z/4BQ3GnVZxilYcWK8XT+d55+iGA99IFZJBsrJ35hcSE9Am+0RWgWOWoMnqam4qK5fUQRK/JqdSbUeYmfbo6ngekvwKaD4GpB4mq+x698V3d8Q2wkhyo7pUTc7P/TOZ3AkwjHxFPAxhbNOF5QHb3/ec9cCNPbMK8sXIkiB5dGWdnqV9/9gOuAJucVHXw6vaD96aBFanV8Ex8BJPopsYoXH9lnme0MUO1/zTRHqRVo5MfkUk/PuUeDM7qzE2SYmS+nLqtCn0AKawZvRHOSHlRKedfDQO4nQicV3G6NI1UC8tODXcE6/IlCJBo3Yf+en+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cianz6xrn8UCa7et5h0o/b9dpvApASZT/epOPoCSlfs=;
 b=kSel0ZvqVZq4nsBNRFvmX0UJa1d/uU36c4q81ugQ144tkZ1446EIUqHPhSqrRLKeO3pr8taL49teaYgVJstA7r5bw0YODLaDWhUlDaI6yDQNS4MkYcL3/04ajTiXkW83faX6ha448xZTRUw6gyTndAqewvzrf80ku+OQzQc9/6U=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB7958.namprd04.prod.outlook.com (2603:10b6:8:1::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.38; Fri, 24 Mar 2023 16:36:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%8]) with mapi id 15.20.6178.039; Fri, 24 Mar 2023
 16:36:01 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Boris Burkov <boris@bur.io>, Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs: fix corruption caused by partial dio writes v6
Thread-Topic: btrfs: fix corruption caused by partial dio writes v6
Thread-Index: AQHZXfjdQrQxDdwoYUyaQkj3W+CSLq8J6AOAgAA5e4A=
Date:   Fri, 24 Mar 2023 16:36:01 +0000
Message-ID: <2334d96e-81ff-8a35-9ea8-40a74b58a554@wdc.com>
References: <20230324023207.544800-1-hch@lst.de>
 <8d44aa50-d056-2785-0981-1535a50a4bcb@wdc.com>
In-Reply-To: <8d44aa50-d056-2785-0981-1535a50a4bcb@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB7958:EE_
x-ms-office365-filtering-correlation-id: d71a2d15-9e30-4267-b424-08db2c85dae9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Kov7H6FkI8xi/k/PhKUJrSbFMzcEGHcM0Pw1vBo8GltzFWq0I2YEPhszEtgqT7DjPJ/lxpJjrzTayc040mwVjXEB/+29J3u9lc86Jv8JR3qOYZHpYkU0PvHTGZHdNzg4neRLEloIlEJKa+IbLJ/lrR8+lPLNyzh5SKCJtm3yPy4YOjJIjyyynSencVyvTXpuocA3vYvARvrzu0uVy8sBcf2Mq1uMYgK4M1x6HzWeRvgG1r3QFq3IDAIUU3aI4qTq3S1BxYIMtE9kyvUg9TGH3w0C+icf7j+VkAnZZZF1PcjFxmqoC2cmS9yyW8hX5alomvE4XUHXEDBolkoOH13dyz1AeoNe4Ey5542qSwtkbfVIhlwDdMQBCww9a5gveBqpKwIMtRe4BIHpGck+PqHGSMxM4XmLtu2KktHF+9DhKpgxCo6bD6FOEJjkU4ADGscZ+LOIZk7BYathMWYsEO5OgssqJ4M+pl3eF2Ii+FM9URxixP2LRPFM/B2qYIhU40xAxxWov04ekxu6Vu9D2pQaKHUeLg3rIOqqQW6FLPWA0bhyzNqm+TGweqUIHfSF9UKAq0Sa6oaGBOzAPnzKMsDBx8ZQHu5+zqiq8iNlS8v+VV2/gxiY6VBdfgJgjGrPpTjKEDueKsmH5/OH31gk/fv5rFNdEqbUUAM+DeOJqD7/cw55OMGFcVHVHiC6OxIUGzrpxZ1m0hFxc3cEETDkDw8FZJk6fW1QwWYcA4ue9ZiLxkVJnRlHnz5ObO+7CQrfFzimtxc+wDywTaHUFcRY0jABA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199018)(36756003)(41300700001)(66556008)(66476007)(4326008)(76116006)(64756008)(91956017)(8936002)(66946007)(66446008)(8676002)(478600001)(6486002)(316002)(110136005)(54906003)(5660300002)(2906002)(82960400001)(71200400001)(38070700005)(86362001)(31696002)(53546011)(122000001)(38100700002)(83380400001)(186003)(6512007)(6506007)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2ZHRld0b1VTSVdKNG02Y3M1RzdZN29OY1lEcmRDQWx6QmpmemRFbmw5VWE5?=
 =?utf-8?B?NTc3ZzBDMlZsZWVqVSthemo0dS9FblBYUjN6WmIrZFhiSlF1dDJoZml0WjVC?=
 =?utf-8?B?N3JVYlZjTUV3MENwaWRqY0UzYXovVEFZNmJWVXBqTkhHazVyNnVWTUJ1WGxV?=
 =?utf-8?B?UGk4SThZdTdaaytKQjhQVzB0bnRHVXY1SlJ3eDNldGZubWVrWjQybm9ZTkUr?=
 =?utf-8?B?b0djSzJpbnRnRHAyazNkOUsrK2xRL3ZzQUJDaHl2TDVYYW9INXZkaXlGV2NX?=
 =?utf-8?B?cnc3MUNDTWZNdnNoU1VZdU5Sd2pKakJaTXp0cG5EMEJrYnpWVmQ2OHdmL0Nl?=
 =?utf-8?B?cUZORFVjMHF3eFF2SWhBRDk5T0t4dXZhVEdJMExWdHVDeS90QXY1NTV4T0F0?=
 =?utf-8?B?NVNld0dKUmJhb2t3dU9oL1VvQWhFNW9IdEE1ZThnNk5acXNUaERrTkd6Tkl5?=
 =?utf-8?B?ZFhvQnl2OG11K1ZKbmNEdnpCZ2JXMDRvTU1yOGJyQkF5Z05jR3Qydm0rWDNG?=
 =?utf-8?B?Uk96QzFrbTFTdjlwM1A5MHYzVG1LOGJNOVc4U2VvT1BnN1lkSXFaYi9VMkx2?=
 =?utf-8?B?b2ZYTFExdHc5aEdZbkVRR09RZy9ndTNwY0ZQVjNTSUltREV4NEdmUDZyTU9t?=
 =?utf-8?B?QmFMcTk4VGh3dmdnKzk3REZRdE15djFraVJGOWdxWE9oWEpxSzBwVERxdWVR?=
 =?utf-8?B?d0IzQTVZcnhRZzVIY01meHcrRk9NdFBrTGsvTVpaam90aVBXOG1TOEtkSzdy?=
 =?utf-8?B?T3NaTm5oVEYvdGVjNUg1RXo0amQ1bkpKSXpNTU9GakNoV0Nvd0kvNjRCaHdL?=
 =?utf-8?B?ck9xSXRDOGd6aXBnQ0lxNFA0Mk40cXdQdzZ3clhyUG1scVd2dW1jcWpWTTV6?=
 =?utf-8?B?SXpXYlNrMzZ5dDNQU0xsM29MRHdDeTZYbzFvdlNtMVZ5eCtPQzlGNzZkcHgz?=
 =?utf-8?B?MVU1bi9QK0l6VEc0Y1phWDdBR2p4LzJYSUt3bHVsNXFVMzFHUlVyVnhWdUEr?=
 =?utf-8?B?Z2VJR0JlWTRMV1g4amw1L29lUGV1a255YWpNL1NlUEdOZzBieG1oS0M2cW5q?=
 =?utf-8?B?L0JMVUxSS0xqTS94ZHdVaURoUkcvWVZpWEpXSktRajgzUzZadlJNRUVjNk1L?=
 =?utf-8?B?dG80MHJJRlo3MmRScDkra0N0ajFVWm9ZaVV6RkVGL21QQWNqRjZjZm95SWZx?=
 =?utf-8?B?R05Ja2dnOG1wdmJmL2MwbU4vKzFURmVkblZvTWRzcTFxK2VCMmx5WkNDVlBm?=
 =?utf-8?B?MmVqQitDZ1U5SkxTQThSa3BsbzJIYmo1R0NYUVI5NGpDWnJqVlpnTFM4bm9V?=
 =?utf-8?B?MlRmTTdpU29tL1JKWkNyZ0hBM2IvMjFqQzJiV3p5SithN0x6YjhZeFJWdHRY?=
 =?utf-8?B?ZmFEWkhaK1BNSnlZTXI2S1FGYUVlRkpnS1J6aDBYcTd6dXdQbFVlU1B5Rm1N?=
 =?utf-8?B?T3RsR2tXUVVFQ0NPbEg2SkVKSlFmZlRVaWNiK1h2czRzUUhReEFRWVdENjB2?=
 =?utf-8?B?VXJQT0xPTzlOUjdPNlRCSXk5WVFiOUcvVHNGSHM0SDIwTXN1NndEYXBvMWtN?=
 =?utf-8?B?SHMvTlNSTWVXbnEzWkRSVDdsQWpVWkU1aDhjZWNhb0E4UjljRnVndU9vL1Ny?=
 =?utf-8?B?K3hsb3VVQ0J3WXRHbU9hUU9XeTVzTFRxTzRLMEI4c25HUXpwcHVwYUw5UWJx?=
 =?utf-8?B?R0tlTXVDSlhNOHJrb0FsT1Jxa2tHOUpzTlpUVnQ4QkF3NUNpMVZOZ1ljWVlj?=
 =?utf-8?B?TFJuUGRYYUZCcmJrU2xJMFdneEpsaDM5UEYwUlhHY2JmSFM0UXYxM0UvUVJz?=
 =?utf-8?B?bmdUL3NVMUk3U3JIK2pueTdlaXR1dE5CbVkrbWJTdDFqOTFiZHg3RzF6RE56?=
 =?utf-8?B?YzRGMDVIZWVhNEp2SWZGbHh6NGE5bWtEdjNmWkxMZDBjb1V0aDNDSi9meVBB?=
 =?utf-8?B?eVliakgrSkllUUtTbmJxRWtuZ2s1NFhkaWpmbkxIM2RkTGNOUTY0WVk2b0E1?=
 =?utf-8?B?bkExSURvSXVZS0V6dTE3eFI4dVR6SGIwQjJZRlZpaTRIcitJOVBlL0NjZ0Iv?=
 =?utf-8?B?eWJNN2RpOUlVdnpWMURSSm90MHZBRFh5MXRPSlRBM1JiZ0FyOWZmSWRzTkpC?=
 =?utf-8?B?eHVIc1hCMllrM2haaHQ4a2Jxb1FVOEtZQlQxRllkam5jZUZiQzdvZzRLNjlU?=
 =?utf-8?B?YWdOR1ZENUN0d1pSWUpxQVBWWmVNMkJiZlY3ZzJudUx6bkd6bTk4NnJUK0t2?=
 =?utf-8?B?Ty9wZmtYZmRvclVCWnFoMXFFQy9BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F9197138669B7448EC5B5A9A25BAD06@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WDv0E+EBP5OzIKvkVLkAlc/PakUqEOi6iJpbSs7PJgQi2L1qdSaQQ2u4dlpY7Aa9lEm9Gfrf3tn5SXbbZq/WyyK1g510ZcoExnBrgvmjVtBJ1IrekcmYOFpI5NbbdncZ5u8GmJoC+eWZaH+PDJXQawJ0p+MeKAu/iBqSjrrmBsJuSJ0DS1L0l19Kh+1wL4ecmBYhNwE5DZIQ1WJAOLbfQhKti6Hx2oUQXZx228N/Fwgff1OeFmXpYZIWX8zcb3pwOL1meiJktAJnc0yH+80q6xg+8OYGKGFb2w4rqmlkIdhxR6T/SCZADRcgbHd9xy34y0MlGOBroyZU1EQDnuQyy1gljgX0L96peCTgfhqb2hcMr005f3j2Xlt324wgBxnOODVK/PXTiXFmHiZvujbULlvZMPwoS8OtGkxrCDm5gWAmbr/UENxlFTs7b3k0KDBcbxu7omtHWYFA6RNt6Vh2O7KKj7ZjoJp27obfplK7DKslvay9d/XutN6wKzU0384E0aY2wBj3l+U9m3p7ZTYzTGbt3VeTFnB/3tHiuTAyt9PHRezgOe4s6b+I4O1afSVVrbrILbZHJgPzkgwM6pTddXkI4VLkGpyUVcIJ1sLBpLk97y8ldbP56eDeA07NC8zBtyATAyQlLIkEhnfqRMU3RPrWKubKKj8udahEcBIscKWIuvPWSlsU11/IZptwzwPk1yPJrF5h2MG15Ed9GY645WYyQ9Nzb6VjMKDwA+p15JGVfvFZmj10nXMrFio4qGN73rlVCnz7K/u8nxrLXkefK5/xqbyr+nrWmWxlWMFh4dK9UATAmsMSbPzUmXqcdQ+yxruqYIBfoKg8bLQO0NJZT334GIRVTh0pzLx9MvNZ9sZpgLSDpcFVNDTU6sZQ3invreQm79NFZZ7ERVSx4AWyfg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71a2d15-9e30-4267-b424-08db2c85dae9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 16:36:01.7610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qp7ZerSc55JU7X9qYndwQqLL+ex3NA4xche7xEQejxWcYsD1+NYdiSMhfphJt6HN38HDs9h/V1hKqNWp93W4KnoYWUFxMF1mSiY5wG1QePY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7958
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjQuMDMuMjMgMTQ6MTAsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gT24gMjQuMDMu
MjMgMDM6MzIsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPj4gW3RoaXMgaXMgYSByZXNlbmQg
b2YgdGhlIHNlcmllcyBmcm9tIEJvcmlzLCB3aXRoIG15IGNoYW5nZXMgdG8gYXZvaWQNCj4+ICB0
aGUgdGhyZWUtd2F5IHNwbGl0IGluIGJ0cmZzX2V4dHJhY3Rfb3JkZXJlZF9leHRlbnQgaW5zZXJ0
ZWQgaW4gdGhlDQo+PiAgbWlkZGxlXQ0KPj4NCj4+IFRoZSBmaW5hbCBwYXRjaCBpbiB0aGlzIHNl
cmllcyBlbnN1cmVzIHRoYXQgYmlvcyBzdWJtaXR0ZWQgYnkgYnRyZnMgZGlvDQo+PiBtYXRjaCB0
aGUgY29ycmVzcG9uZGluZyBvcmRlcmVkX2V4dGVudCBhbmQgZXh0ZW50X21hcCBleGFjdGx5LiBB
cyBhDQo+PiByZXN1bHQsIHRoZXJlIGlzIG5vIGhvbGUgb3IgZGVhZGxvY2sgYXMgYSByZXN1bHQg
b2YgcGFydGlhbCB3cml0ZXMsIGV2ZW4NCj4+IGlmIHRoZSB3cml0ZSBidWZmZXIgaXMgYSBwYXJ0
bHkgb3ZlcmxhcHBpbmcgbWFwcGluZyBvZiB0aGUgcmFuZ2UgYmVpbmcNCj4+IHdyaXR0ZW4gdG8u
DQo+Pg0KPj4gVGhpcyByZXF1aXJlZCBhIGJpdCBvZiByZWZhY3RvcmluZyBhbmQgc2V0dXAuIFNw
ZWNpZmljYWxseSwgdGhlIHpvbmVkDQo+PiBkZXZpY2UgY29kZSBmb3IgImV4dHJhY3RpbmciIGFu
IG9yZGVyZWQgZXh0ZW50IG1hdGNoaW5nIGEgYmlvIGNvdWxkIGJlDQo+PiByZXVzZWQgd2l0aCBz
b21lIHJlZmFjdG9yaW5nIHRvIHJldHVybiB0aGUgbmV3IG9yZGVyZWQgZXh0ZW50cyBhZnRlciB0
aGUNCj4+IHNwbGl0Lg0KPj4NCj4+IENoYW5nZXMgc2luY2UgdjU6DQo+PiAgLSBhdm9pZCB0aHJl
ZS13YXkgc3BsaXRzIGluIGJ0cmZzX2V4dHJhY3Rfb3JkZXJlZF9leHRlbnQNCj4+DQo+IA0KPiBJ
J3ZlIHRocm93biBpdCBpbnRvIG15IHpvbmVkIHRlc3Qgc2V0dXAuIEknbGwgcmVwb3J0IGJhY2sg
b25jZSBpdCdzDQo+IGZpbmlzaGVkLg0KPiANCg0KVGhlIHRlc3QgcmVzdWx0cyBsb29rIHJlYXNv
bmFibGUuDQpUZXN0ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJu
QHdkYy5jb20+DQo=
