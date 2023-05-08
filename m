Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911B06FBB6B
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 01:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjEHXav (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 19:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEHXau (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 19:30:50 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2404C1F
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 16:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683588647; x=1715124647;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=qzVIqkuzeGNmUCyDVm03N2XYqLAfplzdjhgCqau+4eRUXJ1GnUYEETPK
   jJkgSLt9NUDoIstbzmxlxPcte/N0IPN1N+B8KrsxSu3iWu3V0K7dPGXRf
   ANLgF17jhKfGVQFjjazeLf+mg8pbjmoN3zxH5lgDcvLvG/4Guidv22BgA
   EbqgWZdh+GocSsSxFCYZv6Dyd39eyUMfcAjGu6jMCfr3lYLmhP9aMMoZe
   VH8v0yfycl/SRB5zPqk7hSpjs3wxwvQPDio+U1CBznjizpop/Qdrg/XxO
   8d54Y7YZ//hEvoojrePh17tc1PjIcRKF3mcRJhT7GGqiuqDUPBjxQxt1P
   w==;
X-IronPort-AV: E=Sophos;i="5.99,259,1677513600"; 
   d="scan'208";a="342231208"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2023 07:30:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNpNKz4BCVAmXnWpbhqw91XKhzflehM50lkvzf5QDYtSNbLR5Y/gJt2Pr/3XVcq92Dg/S8D9fliopKhpiIxPRL/vJv2xV3k06KFgWT1t9MSYHio+pRcD79JQPyqAvlufLDdmg8erBy1UTZh2VxTgmVFXtmFsFHKKMByCx1/NZmJebw9XJ9FODX6kONDMSSMnGV5rmldF42hGijaql/rGm8T6WjD6KdhJS7AkRkiu67PNGGLMM8Gn6LA0Dlrt958Ca+BNKdbX8AUl2E+pEAqS4nkTEEgSsK4eWzsy3mIViq6nGw5OfFvfDyBbQBx1ul36WFkdg0GTqwqbJkJQ7waHdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=DkF/hZ8S5o2fSPaixqETHL23J+VtHl1TYVs22nq4fvfdzGda6JHGaLjbP6dF/gPf4JejFuaRTm4WmhnVjOqkVGBDERhEcJz3kvbNiOW/HZwRwBtZF+42eMowZyuPfn9sKsoHdysWJ1wWCc9HIXva1e7XErmQ9BJ1FfLysBIIDWv5YhX2rTD8xz7wQqpPqXKmENxf9P88PcuuA2PXYxuHKBIBdx5TJ8atWurFg64YdqBt5E7w3ie2My8NvAqeR9e7QcAx6lkjy/4ziO/VWuNtxHE+ChS7febQkxNefq4rNMhgucIjClc9yizz49N9vOtU0LnDKfmIKLnPp0PUjo7FTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=vc3NMDAAwIKCalR8RogLbCLyadokof1c8Vaqg3v+z0ljZy4CZ5BOFhhmabYIS0n03pB420dCRifP9nvUOsbXwfjrYqphMOnWXHqAPOVqMxJj3nSHHwLtXzDvKk1p4UAiThlzRPj00kgeMgTGlkFmWtAiGexbaa256bIWzPy+50k=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW4PR04MB7411.namprd04.prod.outlook.com (2603:10b6:303:64::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 23:30:44 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 23:30:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 05/21] btrfs: pass an ordered_extent to
 btrfs_reloc_clone_csums
Thread-Topic: [PATCH 05/21] btrfs: pass an ordered_extent to
 btrfs_reloc_clone_csums
Thread-Index: AQHZgcdrt7+8984V6kKHCL/8qu+hK69RBqeA
Date:   Mon, 8 May 2023 23:30:43 +0000
Message-ID: <ba4472d9-2f6a-9185-ea2f-3ffb4e0c3b70@wdc.com>
References: <20230508160843.133013-1-hch@lst.de>
 <20230508160843.133013-6-hch@lst.de>
In-Reply-To: <20230508160843.133013-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW4PR04MB7411:EE_
x-ms-office365-filtering-correlation-id: cf6c2863-72c2-4a47-7ce0-08db501c3e71
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WcQx1dlJZ4ohEWrfKBN2YgWEOZHjBd/PkWCN4y/YtfqEo3sNC88YCZ9NnFnNC4akzsJKJWHLWCS/IY2A10K/jeHv7lUnV0RjQT21go3EG/sEXjjgLXJMf/5XWlSnlMwIBl6pTYAZxDiHk+7QD2O87kbcMYwFErna5Dgf5Lba4Y4GZZ5CEwMmSazoHj3yQzNty10ew7ILFESVDNPKIdVQKksVfJnRoqCNCLE5kB+K+/wL2YFo+OdWe592VHVmYT6+dVwYZD/0iKr5oJhJ9dG3kyNG8IEouTSt8Lt7EY02z5z82GYJIQPycspH3KLud8AmWkLwJBVcNSzvs2MN9uocyHxlN0eOo7nzFKw78R1Ij2HqKLrhG1VUdJ0hI/CXJisNPJIT2jsBiL61JNH/EerEQJyX76FI+w8hknF4I9VrlxxpgBahlaURQYb0hMAs+Qe7Rp6XaFVlgjwRrl6sJEGJdcleKXBIU3tfO3FKjeGfiaqgxmWx3aEEISraAYOYbuiz/4jHPJQ9qxZqHxVtMDxqDh/+hAy0+N+yXUGL5/HLQrIh477s0k2r1HbANGU8E9o4tNOcc3eTuQLEGtX6gYhc/byi02ddEKfIaE8Ps/k7HQc2LhD5Sk4xMj/Uiw9VBQRm+6E555LaDyXZ5s6/7O/gnBYed9pehabKxU9atkBgl7HUIkpSMbvgIHqThilnoSyo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199021)(31686004)(8676002)(8936002)(5660300002)(41300700001)(316002)(64756008)(4326008)(66446008)(4270600006)(558084003)(66946007)(91956017)(66476007)(66556008)(76116006)(186003)(36756003)(478600001)(71200400001)(6486002)(26005)(19618925003)(2906002)(31696002)(86362001)(38070700005)(82960400001)(38100700002)(2616005)(110136005)(6512007)(122000001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVE5ckdPWkF0N1Y5L0hWdWlyRWUxUHFvQW01U3RRQk44QXFTaGE3Mm1ORTZO?=
 =?utf-8?B?dTgrSW80RXBRZWwwd2UxdUFRVXplb3k4ZG51V0xma3gzVEIwRGV3bkZUbGNo?=
 =?utf-8?B?anpUdU03aWFTMHppYk00UGpoVDQzdy9FRlh2WGRWT0xWQm9leWt5ZXFCMFF4?=
 =?utf-8?B?cUpuVit3T1IxYlJOb1NBakluV0VkY0piNXBkeGlnUUw1UDM4UXRGR1VPclY3?=
 =?utf-8?B?K2oxakE3THpIbEw1aVJmaXZkS2RUNHh3L1ljTUlXM1p5dmI4QmRIVGdlNDBL?=
 =?utf-8?B?aExTa0g4clhTa05VdEJ6VVFiRm5MaTVVdC9UMlNxVEh3SGx0VmRodVRIaGdH?=
 =?utf-8?B?L3o5ZzZkTENzMDJzS3NIVWdrMzdkeG9OWG85eTVva21DVUQ4cDBnWkJtT2pH?=
 =?utf-8?B?ZDdiR2xtZTVHR3RESnJGMlo4VXdNaGVjd1RnL1N2eUFhYS8yaUpqUHhlWXBP?=
 =?utf-8?B?bkM4RjRWKzdXVFdmT3VrTTJ1L281cVBrOHdZbWJmSER0Y04wc2E4Mit6UzBp?=
 =?utf-8?B?eUZlWUtUMmRrdDJ0SVk3bTFiU3ozZ3NDMVhIZkZRdk14TmFNeUYyeFQ5dTF1?=
 =?utf-8?B?aThEcTJxKzdPSlo2aW5QTmgrNXJZck5wd0NuSlMwaWdxVUVPZzQ2ZTluWFdt?=
 =?utf-8?B?Uys3MGIzM2g4T25yU3d4eGp0Y0FGL2JqK0Z2RkVKVWp6c3kzenl5dzh2Wk1m?=
 =?utf-8?B?MWZwQ25EYVVtRWNvcVpEc3N4NWMvUENtSkJXdEd1bDRsT0VmOVMxYVBjWmVv?=
 =?utf-8?B?YkRQRjJzM1ZGOVE0NWR2WjB5eU8vblBCL2RKM3VUSWFHZmZkbGFRcXQ3eTgw?=
 =?utf-8?B?bEhheG5nbHJmS3Fqd20vSHRtUEhhSWxLQklmSVVIMTVoSEpDeWVYYm0rSENH?=
 =?utf-8?B?dlp4UDFDb0J3VlVHQXo0WmwrSHlXWGtRZkZlNnhRUDRjYm0vcDNCZ0pvN2pV?=
 =?utf-8?B?ZnFTUXk3RGViY3FnY1ZiSVF2WVc5WXFLY2tWbUxBeDlZWlBWTXlObXBvMXU1?=
 =?utf-8?B?V2VGcTBOSjBlTitBR3ZFbmhFcFRKUkZQRHhJaGgxY1l0R2M2VGV4bzNRdllM?=
 =?utf-8?B?anpqSHFPK1IySUc4S2t1Z1d2MHVKNzBjMG9jMDFIRXFZWXRORTkvV2RWN0sx?=
 =?utf-8?B?cnlyQU5LM0hZQlhMc0U1TTZOd1grVTVIY3NjV2d3Q1B2MEdBQlh5NXlQOWNT?=
 =?utf-8?B?Y0g3SFNTdTRnY1p4ZDF2YUF0TFp4aG1TRW8vNHRjVFNxc1A1Qm9DRHZYSnZ1?=
 =?utf-8?B?bTB5VnplZ1Y0Q2xzY2lHa1BDMFhsQjA3YWdzcCs4M2puMGF0QnloOWhnL3hN?=
 =?utf-8?B?VjkwS0hDM0xOUVhiUFpIbXNNN1dScDh2WEhxNnVrMTBhR3VIRFdUeVR2akpV?=
 =?utf-8?B?OUZNaFZvQ0RoSUFwSDFIUjROa2RDb0tmVzdpNXNnZVk2OFJ0eVU3VXlYa21N?=
 =?utf-8?B?blNjNmlKMW1BQ3V3Z1QzSkJNeVZ3YUp2YTVwcXBHYzNYemlkTlNxK2UrZ0Zv?=
 =?utf-8?B?UTdOai92MzJEMWJqSTVlNmU1TlBxak5YcEJ3RjUwbGdOQWxWMTRjK1JwN3dx?=
 =?utf-8?B?MDJWeW10MFo2cVlrNTJNWTFOODYwTGc4NkhFcE4wOUc0U1pYWk9CYzV1UzN0?=
 =?utf-8?B?RW5wOS9nS3U2Wmw4ZGVaajZRcEt4bFBWdUxKRlJBZGxpdlhtUDk3QUJGVzZ5?=
 =?utf-8?B?TDN0U2lJUEdYanBSaVlkQmFoK1lJbFJheFkyYlEvUThacDdFekY4VE9aZlFz?=
 =?utf-8?B?THNNai9SZ2ZmSEVKUmhudCtwWUREeTBXTGFsQ2hQMkkxQXZLN0lxRG9iTUFG?=
 =?utf-8?B?LzJKUzRhWXNlSTlFUE5JdkM0b3c3Q29uNytoQ3c4Vk5uRkl6Y25uTXNpUHlQ?=
 =?utf-8?B?NlJaQm9xYjBBUWJqVmFqckJoUWtZQUF0YkRYcXJIOUJFclJaTVZSb2RVQWd1?=
 =?utf-8?B?MzNqYk0yRTJHNnE0RGZqM3ZWeFJ3aEVkdjc2WHdWTEsvYzBQNEhzZy80SlBz?=
 =?utf-8?B?d3BIQy9UWmZINjB5ZTVHNE4wQWJ3TXJFMUplMG9ob0dyQnVJaDU0SWNMeXdr?=
 =?utf-8?B?YWhVdTkvcXNSbk5wb2lQSTEvUVgyaWNMNnN1VStCRWlSN2cyQUt3L1dobmtt?=
 =?utf-8?B?WGRJenN6TnJNb1pmNk5Bb2tla3l6UUphdXdmcmlwSlFOK1dpQndrYkdtcWt3?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <94D5F30E1AF46F469602B0DB5D3DEEFA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RJEj6Pln4GW8wyqGuPBbu22cA/sM0H9kPV47l7oeef6rZo9eypoKZpMhtOWJ0UPawJZR4otCfqaIp/0f1VyKRNnc8ypieku58Go4OYOxo8nXdiy8K0hq//uJqdPhtFV7LPxwHnSGu+y2IYjRx6QfkdKchv+ymv/WyqjqKCxgCNRDKcNrykdJN1BVTwhOCnmmvAGYO3ijgqXVzrcSAa5yX3VwWn+d0QY8xqE2iiBcRncfuIItHYUDXuCfbPUlQrxUjr9w7EPweNeVyAqZo5e6XaYL2CxH/u1kFFWZHFj0RHdlwu5t0bpGefhop3etAq+wAnnzdge3kV5Mirsqj2zi+2WO621prVafa8XeSTBUeTkEx9UbEWEwA7cLeqCC6OKYyriJiFcsIR1hsObaXdM/D0ElTv0ZqjIi51kTOPfKVqE5W8g7xlAiiLNQRZbHpK8r2iMidc1e4Jdu88TrzfbJitOjB4T4jmxmnI7XSL4Eeng9u+3yJby2+bgRWO7d/ConXSSIrGzzNR48Fmn9Zj0phBe6x0N4V6MJYb5MIUfLY6/cODS/7JdkaomonJ8A8W0qHpM3zIZhAkokodiIizQ2OHVCx7xQrSFATVjw44FfZgEROsk3kOwbMlSINu7KwRkfKQJ00eAzRGRVGHl/894f6QmqhJXZYvqTDLOreOPRUKeilAd5gjDoCo9W+icfrs79qLXAdNI2wgBf2wg3Jn/VYwdQ44+w097VoZKNzg91anh/YQgZAiFlJxG3ZGP2xwBhRz70izbNwjndcfJ0dG+jiCkUwzex/mi2ql/cvfQGHLtZEzBk8ncp1vqdcIUjBiQey6H1dIu4ki2pywiF/Odst9kPJzPUN4zwXr+glUSVyoCotYWuGiFJDvalJSvxRgrY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6c2863-72c2-4a47-7ce0-08db501c3e71
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 23:30:43.9729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eGtQH02wyk2vJ6oC7qal01tIG21I4CsqqkokYQXiK+8ydslm2JJr5MYGUYsaoYlmKkmozlda+KCxxY3bx7DP31kugW7NmoBXhuh09447ouQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7411
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
