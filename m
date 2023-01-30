Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0090680663
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jan 2023 08:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbjA3HSF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Jan 2023 02:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjA3HSE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Jan 2023 02:18:04 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13E0AD2A
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Jan 2023 23:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675063081; x=1706599081;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=TW6Rg8ChyARCO824+ac5SpG5Sldg1ibXxE27zqcm5EswIp2vu0KdjUtI
   KE9TsHRUImHflvcx0W3OnHfh6u8Rl7/Fham3dA3jfJrjC0VWBPv4z7iYx
   CNa4bHHZmTttLch+tVDNE24Fht3EVqHuDzWU47PaHGKy+DQwC2dQucFDx
   HO8NkCu+YnSag38qKD7hrlj4Dpo0n9w4drYmrssevC+/mVCR7zwYzCcPR
   p2i/CxMrS+sMoZGWP9AX3bsae/BSJE2LWrebrf8thZZkUZf3Fg/WV12Gt
   FspZI7Sy9RchKnQO+O4ooDOGDNP7PHFbAvA3nu5xFfVu6myRj/RQjn6JA
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,257,1669046400"; 
   d="scan'208";a="227028321"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2023 15:18:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i59gWappILxpi3RFnC1QCqf8l3/YTQWCZpKyXYUpI0IPRwXqaPFNagtakAkybp7XY7VDjGjjbRPUb5A6oAis4FHIL7ITkbZM4mDxrfmN46vtFK3kic5DIvRz+2ZrUsxvKwnlJQ+/SfPZWJc/VEv0uoGNHz2Ij93Pw96qb/kqgkwes4QD4+PiufIz89+Z5EXw1Go1G5sKG1b/6VosvSHopbNjVUie3bzf5YXxCGhTh4rCE/Rkf5NMHpc7BlvC+hiI1QUMLk+MPxFRvyYBnnKhouGrhNJIV6vaXpBf7Ubt+WfzcI9ecElDnfM7hGdxAq/OkrRV+GUKGpFk6Q9+5cs4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=NdiEEc4yFDABNaGoAB5O9dZnM8WJkk1P+Wa/SDzepnlzHLCn8yH4aWoMFwG2jMr5wCHabHiT8FT338FM9zrd8GKsETLQQxwc3V3AXy3X3mbHMsi5TUt4oRjnvWJXrlT5pSe0cZQ2Fh2jGiJmjNqaAfKXsVt1KgbjPjm2iAQMySuO+O3oRy20HGmefDsQ6tZC5IiT34V/cagUbeBXEP9TfXXDUYw8PjnVrljI+kO2G7Lg8Q9WwGd183NhDNoyLNmTuK9KJFDhhGxhkVDPAvrHX+7emCPdn92F2fYlCpYYetLlZjNqq9SPl2MQXG3iw4bzWlS2yIfizkvhcKMvQ5Pzng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=EAmkyumnKw1Q9fvqrcZPT9Hke2C0WaeCmixSBmCl2oUxVCTqwdECcwE5VPq/mFVDmkmXhHPopyXSQh9MnGcVuadgRx35JDfrW0mAUMJ8P9V4+ayPbbrQUBwpHpRIF92Hj9udDFml3fU40vt3gmRxDYsHesFwk044VoM/508Fq68=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6045.namprd04.prod.outlook.com (2603:10b6:208:d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 07:17:57 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%8]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 07:17:57 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] btrfs: simplify the @bioc argument for
 handle_ops_on_dev_replace()
Thread-Topic: [PATCH 1/3] btrfs: simplify the @bioc argument for
 handle_ops_on_dev_replace()
Thread-Index: AQHZMvHYF624Jt2eKkG+yhUSPeoP5K62kA8A
Date:   Mon, 30 Jan 2023 07:17:57 +0000
Message-ID: <7a0a9787-4fd2-69ee-fd2e-034535d66850@wdc.com>
References: <cover.1674893735.git.wqu@suse.com>
 <92276451bbeed279f8c04bc9ce684f42a25cfc92.1674893735.git.wqu@suse.com>
In-Reply-To: <92276451bbeed279f8c04bc9ce684f42a25cfc92.1674893735.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6045:EE_
x-ms-office365-filtering-correlation-id: d2fa8241-f55e-440e-47da-08db02921ca5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 80FFrY4BM0ALSe2RQW3hDkqymy/kmuOZIPs+wY9LgZiN9d7IP168F3Oa0dHKhFIWKNikoPSHmO8PllznxYz/BQ9lFaPIVLkbRUwiJ4Z58ci+McQCBfFo70h9/QoES+pc9dmd2s6u7lCtOOmM+4brXfhLYh4A68JlAEpM+e/R7jXNUMXZzC8l/P+UvD5pSfTLvBW3y9SXYVnGjrMEtNgnvTdcbYRtlIriM/h6QzP8u190WJuWLj9YeBPzT6n5Oy0+LQmf/mNGO02sxvKeJBEK4qIafRNl+uXv/zxQgtpQRHR4MhXAsO2f+1mqOfaRJVcKpcqPkHKjAWemKhokLOqJ09rXaFuusUSI7G8SlXnarkjGwlB+6d3qFlUh7w1xhQ6EL36/O4wywKYfyvfQkqtXIWQk5OubaEs1cnvadOBguj1jFPgBsGTVbXygj4K6B46XAhHXlSpfhDc065tixKpNRkhho1+BIO+0dgiNtzSdqae5HpiSmQkKsbv3RIs99Dh7xHU2rsv5AQCqOjlsHV4BVnpLK9YDY40y3IeBs260i761gKDqGyt/JMcNYgDiEy+OxMlmMgJnm8WGIgFsj/SddfDndK2N0Z2R2b4zV4kHGYUeI3OIzaIrUEDmVPZ/wdpStDQE9xrXZypINEXQvt8Nqt1mY3vOkEaxuroXOiX1pHb29K7F/665Ngh9td4ngCC/z7gxxUy2+IrDUKX2FTRdnZJqCELmx6Jzrn2wRiQgkvCRykQRU4SiHLSgaaSucXbGOVUd9WfX7bdsBD/G+2TIsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199018)(8936002)(316002)(6506007)(19618925003)(86362001)(478600001)(6486002)(2616005)(38100700002)(38070700005)(82960400001)(31696002)(186003)(26005)(6512007)(122000001)(71200400001)(4270600006)(36756003)(110136005)(5660300002)(558084003)(2906002)(66556008)(66476007)(76116006)(66946007)(66446008)(8676002)(64756008)(91956017)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TU11TEFPN09aMGVqeXJsVlRBdUozOUdqRUhDYm5Fd2doYmpseDUwTkh4anJB?=
 =?utf-8?B?dnFVeWpUQnZLTUY2UEJGZlVrcXIyV1kwSE5CcUZ5ekhISmwvbFFmVCtTZFVG?=
 =?utf-8?B?dXB3ZG4yUk1vTW1qWWlLUkVlZ3BMOWIvdmJ0SlJPbnhiUWt3TFRqVVdKcnlS?=
 =?utf-8?B?cU9yQ2xwUGNFSXFrRlJQMTZzbFVjallua1BYUjRCNTM3Wnc4TlAvaUFQZGJO?=
 =?utf-8?B?STlwVEh4WGI5YmVjaFBBWDVWTytJU085UmNJdVpsYkd1T3FDbTFhblZFUlY0?=
 =?utf-8?B?eGhyTlVLVEJyZ3ZRRCtIY0JaeE03SFlRU3U0blIvUE5NOW5uamJ0dHdjQTFN?=
 =?utf-8?B?a3hONUJFRXAwVzRmRjlsVUdaMkRYQkFTa3JqaFFkNTVTMmhXSEdrYjY0WStM?=
 =?utf-8?B?L1I4UXgwbFdkY2RWbURjb3dpa1F4bVZTbnIvUWl6VkFOSXpJY29haW1MenMy?=
 =?utf-8?B?V2UrZEw0WUhNN1FJajlVTWJ4RFZMWGEyYlRmUm5lT3FOWnBTKzlVSG1pOGZG?=
 =?utf-8?B?dGlabWtPd2hGekUwR1BMaDdhTXcxMmNpYTRXR3U1MmZjRTFqU2lnWTliSXU2?=
 =?utf-8?B?MFBKZU5BaUZQanFBTVlEcm9MNURJa0VvTlgyZFVCaUNrMjhUOHFMN3VjZ1hv?=
 =?utf-8?B?VzREUlRqazZiR2VJVjMxRVQrTHFaM08xVEl6aVhNTFZxWEhSQkFnd1dLUnFD?=
 =?utf-8?B?OC9RWElOeHNVYWc3TWZSY1FhUGYvek1kT1o0d2g0cVJudXp4RnN6ZDFBMi9X?=
 =?utf-8?B?czBib3BUQmgzZThEV2lYSVZhQUxGeDd3Rlp2YkNwaHJaa2lObkUrTC9mQTlu?=
 =?utf-8?B?T3NCMk41TFJpYVN3SEtPeWd5aE9wWnJNK2thV0VSQkJwcXo5K2VSbGpsSXVq?=
 =?utf-8?B?ZFlaYVlEK1BIOGpkU0ZTS2plNyswTU9EblpOL1oyWmlrOFU4Q1VxNGFFdzhN?=
 =?utf-8?B?ckFHOGlXb2lJd0lZZVM3UW5mYXVrV3FVUjBKUjJsUnRpMFJVejNRbkphcnNP?=
 =?utf-8?B?dmI1Z0ROa3dNVzA0M21JNWZuQzFTOHNIY1MyNXplSUtrcTNBdTBDQlJmWWRT?=
 =?utf-8?B?QWFoZ2FDWENQZHlaN1lvM1VUUkNleE9sZGJISUdyR0gyZ2dITEtuQWZPYk01?=
 =?utf-8?B?RE9JQUJzZGVnWXVzaVNSdTN4eElMUEtCcVhrUE1rOTBoUTdpcEczbEdBMXVL?=
 =?utf-8?B?bWQ2djNuZXlCYlZsYXZnTXlMZUVkNDJUNlA3QTlUeXJnOXh3WFdCeG01QjR2?=
 =?utf-8?B?ZHZYQTg3dEVlN3A5QkZ2QUNKdXZ4TG8vUFNGcEx2R1VIWUNRNWhvcmlDUmdy?=
 =?utf-8?B?a0pPcktyMzZyZUJjUHF6bWNtZFg1Q2pBSTdPYVdVQW8wRm1nZVltM05ka01M?=
 =?utf-8?B?YnhuQ3FxclFPM1VIbUQzZHZjbTRnK1VLeWFtcGtuNlhTWHZlaHZDL2NIMzJI?=
 =?utf-8?B?ZU9XcHFQbWh4anR2VTFVVzdZc3cvVk5pSHdPc2ZVOXJENzFhUFdvMGJYNnNm?=
 =?utf-8?B?emRCMURkQVJnZUlrSFV2ZGcyNHZ2WXoraGVCOEZpTHdJY3puY1NnVGJIRDlC?=
 =?utf-8?B?QlQyOHljTnlzbURDak5FeWRrbm9MMDE5RlRBd3R2WkFpNTBMZVdjYlhXU1ZT?=
 =?utf-8?B?d3N3ajVMM3NLeDJINVI1Snl4ZEpvTmRZbUlCQ2F5ZEp0YWZMM0Q1RFZTaGJK?=
 =?utf-8?B?eVBNQVlSRGZ1aGd3aXk1cVJhUjJCTmNEK2dRTCtQbWpFS2pUd3M1K1U1S2o5?=
 =?utf-8?B?Nlh6YjZDUVVLU3NudDJvZk9LSmZDTGFIQUtmSXE0RjZxdXMzQ2RHUnZYbG9w?=
 =?utf-8?B?bGIvdE5mVGJOVmxjSzg0MzY5ekh4aGRvbElWU2toNVozdkE0MWdXcy9Rb3BS?=
 =?utf-8?B?S2E4TjRiblYxSkRiWFc1aktMOHNXbzVzMzZ4eGtyV1hYRTcxTFhFaC9nRTU4?=
 =?utf-8?B?aFdSbEI2MW5xbDRRbkhZUDNSQ3VXdGJQNFNFTGJuVVNUV3RBZFFyWHg5bjA1?=
 =?utf-8?B?YU1mYjBEL1N0WjhjUnZJMjZqNVp3NytFczJwdkFSWEx1WHBkNE1OYUpQbk5j?=
 =?utf-8?B?TG83eGVTR1JtelBTa2xkMlA1NVQ2SUltK08yOW8vNUdERE83ZlRuNGR4UDFa?=
 =?utf-8?B?azBVdTVuUFRXZ0VPbXdIRFFPUUp3dzU0T1JGOUI3bVpxYjVyaUhFNjl2V3Jx?=
 =?utf-8?B?QlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FD771BB8A164E49AEC1148AA0818729@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GBZ9rTvrvsgsz0Ld+GhQnYHvbKwy4Ou4niAVdy91hP6AtzjlOwIYMHNq6qObFmnqRQGuDqpAPBl/XdrHoE3ew0K5cgMRjvknKTF7qTByPVKLfVu3ALlS3bY8KsiktMadlhWpHEVyJ2EqBWz6o9hVMXSj/QFrjRb0gEpq0X1DZLdgh7zxWKyTUFShrs7gclGw0gsOvBVW2Gg4mqQOJDno6d98TpPmAGlVfPMPAMaIEce/fos949uOV+DD51lHkDQxWO8QV7GQQiWhY0kxve2Hk8rmqr0eIdwOCzCEjBj1dRYcc9CUEohKIbROnFgcgmbI1CfwuwHkKC2y2fK6cvGSkOJhcLgJLhv8e9USaLemMj2WzXUzGzpBDkVGrw6Zd6pwgY2CBc/lORvlZa2O62JUMnp7MNiS3P2Dl4/suhIniLijav63SF+kHS+ozjuQSZkxfxeJ75mWztqrcyAqgNpep8ZpzdbMYstx8D4gzhaO2PMg+yHzNtoBIkQhxOWzYk6nDbG4idlgoeHWBbKFAp6ElYXNWLUyFjk/PQnZrhUVmVFN0PtF7hUgbcJdNt5sPbenholw3+TirE8mvntO2G3ZELyVJHcGcwUR9ug+HY9Fot2ivDIqj953vDhsB5z3eJMk5982RCBy6r/CWrG96uQXi3p3udVvCw+PRHhOeCL1xPliPw0cydg5tL09API/5tRh3foUJJV8If21hGkC0TR3g6F5M0DAfTF0MNUBiUOZ6iO4yuQnadpesTnBatvOOBOK1bk/uQwhQfid3fFgrhwYdF4xKH2ZHDe7ZgGyXS7Fv45zMBDMFv9//UXn3W7b0ceg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2fa8241-f55e-440e-47da-08db02921ca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 07:17:57.1975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m+A6LJADXl4rz/rJ87jBaLlsKIqIn9JjJHdG71iObuoOWHmPZtFLFFyHsgSfmiHPzx41LMXvHzgHhpTxpMai7QI1up/A6RETheWSkqx4mRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6045
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
