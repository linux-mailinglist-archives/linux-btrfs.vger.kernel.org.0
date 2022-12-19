Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCFE650839
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Dec 2022 08:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiLSHzM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Dec 2022 02:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiLSHzI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Dec 2022 02:55:08 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937F0B4BA
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Dec 2022 23:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671436507; x=1702972507;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=EjAZgl/pqoH5ObLVDHcmnMDh2xkzlSOsy5lanpTa25A6QoZSRQ5cAkMG
   WUqrQ+bVQt1M5SE36yTOUDnf4Pg5kTAdygGgsjYwo40q2UbdUCkSIGZCO
   F0et9bqCJ6Mg5TG//EB4/2OUEZ8yumGV9+hPMewXjCQDJGlegBpQwkomJ
   eWcr/2zyUSP3C5Lx4Ip16aZQb6PCBeSg0bYUdNJQoWRkFppuxI+d8hlvx
   tv4Zv33hZaXS/qDf+73XNWTrleXoHwi6zbWE49CNYyXfciBwoU3rnT6w/
   5fcawI4osVu9Tm1gmHpVMBN81iGeI8kv/xo3KFOiYV9/wHjJw5vo3NvnR
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,255,1665417600"; 
   d="scan'208";a="224130457"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 19 Dec 2022 15:55:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6K8Mg6o1/4EKaBiKoIknexPCbVUKwfEDB6RJD7StTEiaCCP2gbayjQtF4G2XxxL5din4L6pKEBFb3s+XR2T2vC4XUD547BZIMatO9INvA8zyc27oCJXmOcLeiqyhlbOekGqGLLF6kLXazYnckcF5I9HVZe6Vn1rMiYWtMmoPBdviNak0JRKe72iyOzCkOWUhVrOHhcF7c3M0SpoSVe/vqXWCeAfNiDi9AwMPRLSnCCM7GvwxPaqc1UlhnnInRaOUVC/gPQUw+m47N2TXeofSjmgtWyIAoL0VUxW+u1BusGt8t5DMJFlCj4FRS4gJHc330NFsgGy/1KsvsVdH6DGsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=EbI3OXTzOa81VXFPw90Cl+tg3zpIPjeKAv+sc4Lc/0yxz3Galvhgr4q7RY/FMSy9dutv9qwuAZbCAmblCIgToWtAi0mfPjSAV1w4QVOQ/Ke2aYpdm/uyjoVHzqsXpzA6Q3FhsBmqvFviBqE/8wRuXMbwDni1aLa5n1c6Tq/CsAZjf0nh6tTaCSOUv/1iYycZ/GRX2AtzZQE8J5fAsYkYcFsOy421UgtxClvSfR2gh7iwhxp4FzoAIrfI5hGgDVvDaMyjquDORbERIpmnCLBMaf3QzgfWVXP1yarSxEHbYUsNoD9qDB2pDXOMDlEEJrPoctvLFznTAMAv07NCaFMx2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=UHyb+vxI745WLYRoLSV9aw1FR6SO9cvZr3nrTdlUfW9H9W98u82cE1RFcBWJae+zIKK6gy68/YkwE3BprCEr0A+0wYb8sxoSfIYk+hQWxasJWzTDJ9M7/lQ+VsI5Rkt2OMoH9Ptkngqs3L8jI6y87MSCFQKEtacHa4RM6a8hDHI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7748.namprd04.prod.outlook.com (2603:10b6:5:359::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 07:55:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b%9]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 07:55:05 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 3/8] btrfs: fix uninit warning from get_inode_gen usage
Thread-Topic: [PATCH 3/8] btrfs: fix uninit warning from get_inode_gen usage
Thread-Index: AQHZEYt7U0cMb7BI20KZZ4dxTynOxK5021KA
Date:   Mon, 19 Dec 2022 07:55:05 +0000
Message-ID: <d19a3a35-e521-dd36-6e8d-34e3e64e5103@wdc.com>
References: <cover.1671221596.git.josef@toxicpanda.com>
 <aa2e624f5626b37a267ea123baf7db2d76be41ee.1671221596.git.josef@toxicpanda.com>
In-Reply-To: <aa2e624f5626b37a267ea123baf7db2d76be41ee.1671221596.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7748:EE_
x-ms-office365-filtering-correlation-id: 313ea28e-bbca-4bf1-02e1-08dae19657a9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L/Pd6XwTwHYnKfSDTVCwWHEPLEn5sXIgEaM6ZfOWPJ/sHVEBDCD5uLyRXlXh32zZYCmnxZdOXNCIk6xmiKXnqbGkAr2yW2wBxBWo34vegQclt147SFnXIgrEO53WDJ/l0luYZqSKb7ExR/mlqCEe+2Wg5Xdogexf1lY30ak8u9K9ZWpIOgZnCb+YUSlj61gnkp37JH5GylhzxOeGY2dRY9AJLykdLuFkklMK0ToF5Se5YyhgCdCkrw+ZzglbCgP8ibYtULL/i39fR7rHp1r16c6rxs6uxbIR8YPPdYuyeXWoWziyeCQlI7ncjLBYVsYQFsto+2VRndZwAEQj3J5+dd1acVUDP4ZQbQKY5HNu17VQMqghTbeRcxJxIpNJq5zlxhDDSdIGG8FkLik+2DhzEEy/L/++qyWGARUYls7IC2fnDrVyhL00YjfEirww21OCASsdXjMOw466AhhSIDyMfj3HQDYrJfjuhGBKKBSqS3Cej5ACzwDmXziooBRFPj5B3Mj56HJZrG4y4fZ4d5tr/hL7JVdq086nj3aj+SuYb6tErcOh1U46C3yhlsgg8nJy5XWGqhY6ioZgk8bNy+0ATExmxBtv7pf71e/MXeS9y7cMvCpZceUUnE5Aux7m3DJPKSftoyoN0CaG0Do0oO+TPjlCA6DDRZh+5bKI0NN9NXtDETnHIMhw4ct9NfvCLx2QlGYKo1I8K6HnY5lh09C95my6CFgnOPMfeUL1EmFRzVws4rzNd8C6QVtP5FkOpeyuzG8t8/H9rJwPFzstHfLkRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199015)(31696002)(2906002)(38100700002)(316002)(19618925003)(4270600006)(122000001)(66556008)(64756008)(8676002)(66476007)(91956017)(66946007)(66446008)(76116006)(71200400001)(110136005)(86362001)(6506007)(2616005)(36756003)(6486002)(478600001)(6512007)(5660300002)(8936002)(31686004)(558084003)(82960400001)(186003)(38070700005)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0JTYWgrSmRacjZEK2l5MndkSmF1ZFFxSDJmMHgraXJpSzdmK2xpM3BVcG5T?=
 =?utf-8?B?aU5JYVBZS3FGS05DbDl2MHlFU3lPSHJtRldXZk1NVnJReFlzVHVOUUFjK0VI?=
 =?utf-8?B?ZWhMdzl1aDNMbWVmaVMvcWo1dmV1S2JZdHpNd1hXd0NWenlFZzgzS0NWdURh?=
 =?utf-8?B?cE0yMTZsWTR3OEIzbkJrUThvZk83TXFpaVJlRGJ0a1BMOG1jczRyOWdEZWdS?=
 =?utf-8?B?MEhSS28zUHFKT3VwTkw5V0NhRzF5L2dZa2h5Nm9TNWo3SDAzVCs3dFErTGxJ?=
 =?utf-8?B?SkxlSVNEMlZZMkpuYkRXZEMrMzFEZVpYdjdrb01zOVhNTGt0VHZQSnZVbG5q?=
 =?utf-8?B?QjZndnQ1eGE3c00vZXhLTzFvZlpxRTBiN1dxNCtCVmxUSWJaZE1ScCtlYUZ0?=
 =?utf-8?B?SFdoeFlxWWNGdzE5bnUrbndmZ243V2Yzb2tENVhKdzQ4WXZtZldpOGdSazlC?=
 =?utf-8?B?clFwUkNWbWRJRW1sM29qdXZWNkFRdEJBczRnUndqL2xSYzhxUHVnNkNSemlM?=
 =?utf-8?B?VWJBM1RPVGcwTldKeFZRZ1BXUHk0Q05FTHFqb2MyU1YrZnAzckdSZTdLeWtX?=
 =?utf-8?B?OXJ0czh0VG1meFU3ckV5VWZ5WVZFYW1VVFN0NXBJL2lzM3lJUXFIWHBIYmRP?=
 =?utf-8?B?b3BVUVowZ3YzTlhCSXBlVVROT01wbVQ4a2g5SnZvYndQM1hQM1Npb2hPWTAx?=
 =?utf-8?B?Nkdrd29oSVMyeFUwSytReTBzaCsvSWdya0tSN2VXUGZYTlhZT1dyQW5ZTGJW?=
 =?utf-8?B?RkF5Mms0aHRieUkrOCtKWTFWQThQNjZOYWZRM2xmRDFoNUl2OFF1NVVQUHBk?=
 =?utf-8?B?eUJVSFFRUVl1dkcrTWlDSnV0Y2FQZ2d1REdHdnFMUTg0M0t1dWh1bTFVU2gy?=
 =?utf-8?B?RE1SdzBIOEtuZjVSOTM3dmZ3dVJ6Z0xualhRSXV0cXdSalYzL3l5SUhKczUz?=
 =?utf-8?B?RWpHUm45V3NuQThiTC9Md2JubnNtUHVaRTlMZGxZcHpsQXJmRlo5QzEra0w0?=
 =?utf-8?B?Y2cyY1NqcVJFZ3FibnlKWDlvcHJyVytIZlplTjdJdDdkTlNkcmVJNXdkUytk?=
 =?utf-8?B?YVZEOHJNSE9HSExWRFc5eGwrc25qVjBUQXFENVRQQzVDRCtaR1BaUmo3QThh?=
 =?utf-8?B?aTRXaHZzK2RlRzBsYXB2MUZEbmhxUnhyTHFJaldTTFJLREE1NUdQVEZTbEZr?=
 =?utf-8?B?SE1KYThGZXdtb2w1MWxJWjRZSmNKc2FjNnZ5QWViZ2hlRXo2eXZoVXZERm1j?=
 =?utf-8?B?SDNzZTgvdDlraHUzL1BuVzlUVzBibGNHc0pKRWFrbDVVWmI3RDR4ZFNQK2pO?=
 =?utf-8?B?bC9TaHhYbkhzTUd2dEkxUi9vdHh5QzZXYTV3UXpic0Jmd29HL2tCdUlPaXFB?=
 =?utf-8?B?WDhWMXMvV0gxSnNrWEhsQWR5eUFzbC9JekRpblFqWXRlbXh3RTR0ZTQ1YWNQ?=
 =?utf-8?B?b3BQcndYK0NsNmRUZm9lVm0zL08xMFdMWm9uU1RpNkNHdGZmc1R3NVVjNlhE?=
 =?utf-8?B?UFg1MS9vT25mczNGYVRZbmtQbTZyVGtaR2tCeGdpM1BRckllWTZCZnYyL0xL?=
 =?utf-8?B?RkY0T1VDRkRSZHBqUmFuamIxMjEvVzgvaENuWGx5WFBYVmErQ0VVblhybmZh?=
 =?utf-8?B?SFFaMjlKcXlWeUI4SUhzcC8zNlg4NStpdWIxdEJlNmViVHlXSmlUYUUwdEZt?=
 =?utf-8?B?cVVEek9uMWhnYWU2VnQ5SnVOdkZTUzZnMlVzS3JCaHZyckh5YnZMc1NrdWg2?=
 =?utf-8?B?Y2wvS1ZRbERmaTM2dElOMFRBc2s1Q0prdFZhRE9KN094bDRaYVZFQm9LWVlL?=
 =?utf-8?B?ck0rRmlhNTJZT05uNWE3cXdGZDBieXFQR1E0ekxzaytvRnN4WUVPQkhkc3Bz?=
 =?utf-8?B?ZlE3SmdWUk1DZGZQWExtdnZYTkZkelR3VnRxeW0yZWFTc3VhTytCYS9lbFEy?=
 =?utf-8?B?R3d5S3J2Y2N6WHMxRnEzZGEwc3VxamswRmJKcTVEblRIbTM5RVJybEtNc2l2?=
 =?utf-8?B?MTFDMW1YZllnQ1RQZVR4T0JrVU4vTWRuU3pQMTdJZXNIUFdhVUhZNy9leldy?=
 =?utf-8?B?M2ZzUjJTbnJ4TTN2Zkl0T29tY3Q1MXkyUG9nS3dUaTRoNURVc2JObCsvRk9V?=
 =?utf-8?B?YVVnOG1HenlLanhVMmx4Ym5CQk5YWGc1WCt4Y3pJd2c4NTVOVnZNazdQRHJi?=
 =?utf-8?B?eUxERWVyRVgrL3Arek81bDBLbUlmS0JtRFpuSXkwbUpPOUU3QkdzaG9ESFN2?=
 =?utf-8?Q?FRajwJhVgFvla5ZCInVmUUWiV/yMw2uPGwWzrUsdkU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D261A4BB882BB43B9901D49AFBE0A9E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 313ea28e-bbca-4bf1-02e1-08dae19657a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 07:55:05.7759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJXUXO9LWEPlHaAE73YSCTYUHKLI0sRPROsq6/qTMWCZ3ziXMwo5TxTfaMhsqkNN/VumCZLWHbMJ86lEltQp4QJmMMfnhwML2xQyt57R2Cw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7748
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
