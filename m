Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C12660F4CB
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 12:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbiJ0KVP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 06:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbiJ0KUx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 06:20:53 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1244383072
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 03:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666866051; x=1698402051;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=KRQHB/6t4kcl/fZSUFbWb29mh6g7qQlq+bt08H6+C8JdBVhvnMBt1yit
   RgUZVhwjJ0ECDEp9B/Vsxug72pSgfErdwFXpHnoIJ3BCPe9OoGzcdUrkd
   LnfPvoh00NdvkRMQMPgINgXBMBa7cSbac6OEitNj6YvP0sm9iobu2kNNg
   JnxH1sOt5SicwXQYsxihNXxFAkvh/pW6kZ+znsa4dvhFq5nJ1OsizPgF1
   /qHuCENMG8c+fTQF8J3NhIEUN9z6dgxalNsWTtaHHZBbU5ykU5UEhKhaD
   bosQ2uJZGEUWBJx5XOUU0ObeO/FSWm1Tlq+8a4LnkOr/sUafldxQXm7q3
   g==;
X-IronPort-AV: E=Sophos;i="5.95,217,1661788800"; 
   d="scan'208";a="319191835"
Received: from mail-bn1nam07lp2046.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.46])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 18:20:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auWmh90HHjhFrGmAjcHTAfn0TDp1BBaQ/2tE3+3VkBCPv0ZTRDFmh33y4MuMs52xbVet4O4H/ZDeKC1XuGspWZXnV6CZ26LZPkFLQ0Nl/2xMH6LgMAgnhzUfzuUosJw/KJKssfl/kH6/cNwK3cHqKYjH/9FuYEt+cfn0zo5kkUvbk6TEM1zH+4KG2Tqzjzjc54EOpAjGYzYmtF8qfoMo8vZL1f1c/22e29CbWJ3Vxkce3DFZ43kcVJ3iIsh57eIFB3BjHbWXPRLJRIVLFT4JqSGQ9VnAlt4c62LNVt+c6qpLoumB1NrblPYvYsxZas3Z6ByjCy9E32e4RYWfU7T9ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=fl2WPRgIdPiWTAGmgA+yUSu6PEjZdfSMrdC1QUwFeCHPz1kOPkpy4tD09MrEOPA/o8vRitbrldmkrZzhkK01N/QvuTKXMpVjLH4hzvHJZZ6FHMVSZXQ+ZCVJxepKCCclzsPVx6rWJMF4H6afDDAORPjPRC3dL3IatgukUqQwJqgSpzWxlLJ+5rQHh1ZZGS55EPWAleHx9YKdwUddT+eQQsR0EJqEmSYaK0J5K4ElpwZ2nlxLbVkDG2jT7q4FqS+xgk4vQjzw2r/lrBAe/SSb7dQA5+/+cr4aCYjeFuo5xS4DR4Zn1Q7izeOxFHi//QJx19EDlFNDS2YCuTXfsReYiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ZXiIUD/3gERRzDCMfhAab4ZAlYlCQgEhstS2xNneOk1W12ggju/mYmRHzjVSEFHv+PTgezGZ3dRSd77vuss7u3sGyTjDjgQcxVMZB48bg+lH8LOFi5BK8rNnPsspI3iUE2Mb9hQYB0KNiuGvibJM3aTl4+AasqDXtsyfheivl4k=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB5524.namprd04.prod.outlook.com (2603:10b6:408:56::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Thu, 27 Oct
 2022 10:20:49 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5723.041; Thu, 27 Oct 2022
 10:20:49 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 24/26] btrfs: move super prototypes into super.h
Thread-Topic: [PATCH 24/26] btrfs: move super prototypes into super.h
Thread-Index: AQHY6W7pRJfAj41TH0m2eR1iDTquSa4iCLOA
Date:   Thu, 27 Oct 2022 10:20:49 +0000
Message-ID: <3f373647-2ed4-03d2-c689-f9da3bb88391@wdc.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
 <c0794bdde20ee17cc6badcf059a1b870f5b470f1.1666811039.git.josef@toxicpanda.com>
In-Reply-To: <c0794bdde20ee17cc6badcf059a1b870f5b470f1.1666811039.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN8PR04MB5524:EE_
x-ms-office365-filtering-correlation-id: b54f9112-62f8-47af-8331-08dab804eb84
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5I/TuJmxIfLPHaP+KXpb9+ntzpeSC1hT/TILiiwEciFNTKfRp3dWygqM+XCv2n5ypXVGI+FhszfhFj9ee7Xbi/VTBVKVTn6l+RnHnkpsAVBm8M41Eh8o5q6Dj+2L+S+93Z7PHG/KqMKObQqHStRNzOAOWeZwBMaLXTs41wLZnU5mTTlV+Z0GBP93yI2A+g5+s5W3k8sO+bKL7aEN6zeYQpR2Axjlc+asmMc16AW3hUk8lSHUj9429tcztd2B+rnzF8WPZiCIkMA07BLmmgBsZ9ZZOlW/GNLezXimF2BnZlXIYBEo4fcY/EYqoOKxy8wflGTKbaf3dWoFjb/JqgNbah8RFFtkOAsjaOMrfQM2sB3njcz057SqQUTh8IMzbPefNCpfoXawcI8vpvhZVf4tuvGZb3he1/gqydNi8hxG51vBdSe/y2e8l/GzFcIWbIeO3lJA3SDyU7f4oo06K0ecM6dgITmZbmgPDdyP2NuqGydXFubf0AuuBdguXIbB/Sab7eGlJFc3SN4P/IbPyIbuQJMsDT2MBx9FomUII3dRQb4hPRonPzkBFyIjJaoEaVoQEY+3mkQ901dv0JFg5KrRcN2R+kHf9zl7/3OMLfixSnDt/t0nyJRgenL1xJrhyj4VGxE+fGjoqAs1vzQ7E50j/LPU/fWvDc/iPYqAM7KIuH5bJakrrAV3LN0Jb/oj8lB9VAE5TjACD8JmEiww5gbLcpGAFoXq2WNJfRpcnjPukk6UDgD4jRtZ70bgJu08/nSBit/gaRwN/2GBrR+3CMixVQcMxvlhCOT6A3PmvkdD1PvyO0dPbBLg8ZLmrLwjukSGSE81r5unw6jOmI4m3R0bgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199015)(36756003)(31686004)(38100700002)(2906002)(122000001)(5660300002)(82960400001)(558084003)(31696002)(86362001)(38070700005)(186003)(6512007)(4270600006)(26005)(2616005)(6486002)(71200400001)(478600001)(91956017)(110136005)(316002)(41300700001)(19618925003)(64756008)(76116006)(66446008)(66946007)(8676002)(66476007)(66556008)(6506007)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzFTNmQyaU4yYjlHRmI5cjZGa3Q1MzVUeEtDbnRnc1FNQ1c5UXQyZzVPTUtY?=
 =?utf-8?B?R0NhZVVFNysxcE1tb2dxa2w5KzlLa2JySG83bVR3aUU2dmhtcVJIUzZDQkxW?=
 =?utf-8?B?eW9MMHR4VGZJa2tuMkZMUVNYSGYwNjBsbUNMd05oNXVucjAyS1l0MVBYRWlj?=
 =?utf-8?B?aEh6ckpTVjhMVUdBOThMdkM2WEVvYkZ4eFFRb3FMemtRcEM5dk56cnJHODBi?=
 =?utf-8?B?WEM1NnFsc0NxaXEwU0szMTdWMmdURlFZNGxtVjRoc0wvbWVKbWtuNkJTeWxu?=
 =?utf-8?B?T2dSZXN3M0d4aHVFUFhJMnJ5ZWMxYmhCRG1wazBoeDQ5ZU1Lb1BFY0tHMVlo?=
 =?utf-8?B?Y3lzczhEWkZpaGVnNW9UcGFrSDdwZnVJYmtMeEVOQmR3MDFpMmNGSks5RjNB?=
 =?utf-8?B?bngzVVMrSkdCUEgrSm1YdG50RlpVajFJRFNicHFrWjExTTNnRllSOWVTYlho?=
 =?utf-8?B?UXBHalJFdDRhZ1N2eHBuVjIrWDNHOHNDY0hkc0FOY1Z3aDJIK2Jad0hYZnEw?=
 =?utf-8?B?VU51ZmRHc2o0ZnRsYjJ4dEFVTmlWNjJXL1BKMWxvbVdyRUxsSE5UalpUb2RR?=
 =?utf-8?B?bHhXeHV2N1FsODN2SGIxS09DdFc4am1MM2xRQmxoL3lrUUx4SW9Pbm5CSTRa?=
 =?utf-8?B?Q3AxNzVZYm9MSkNaWTQ4RElxcDd3Tkk0c2lQSmpXbTkyMnUxbnJ5NGM3U25Z?=
 =?utf-8?B?RHd6RkF0ZDZEdExmakJYaDVoc1NuaS9sWlhUYUMwam90NTBrOVVVdjhmc3ZU?=
 =?utf-8?B?dGU1d210Q3ljUFRmWDBOZ2pXYUNCd09yWngrRXJLcFRiQjNuL2ZmVXZuNmZU?=
 =?utf-8?B?QTQ2eWpWL2RZbndubFh2ZmNUb1FGc212R0FYT1RHSkdIZGY2M2NsQ0M1eFZL?=
 =?utf-8?B?bUpLa3c4VVhvR0dHMXo3Y0hKZk1XU0o5YitFeFlRWGJCYVFia1V3UmR0bHJZ?=
 =?utf-8?B?dEp2dHdUWEFkd0VFVzZuaDZRYWh5YUNOc0dRU2Vza0Ezb2l6SnZRc2pQSHR4?=
 =?utf-8?B?OGk3aTBiVHg0YnJiSUhQOXN4KzMvcmRLVktka3pIOUhiSmFJWWNaenJ2T1Fa?=
 =?utf-8?B?TkRzNFYvT1pPQXVWVVplVWRNaWoxZk9aUkcwazc2bzN2SWdERlFGSW9CdHI4?=
 =?utf-8?B?aHB3Z2svbkRNSktha05ZZ0RxckNSQ29zbGNVaVpEN1I5Y0VhcXFSejRzUEpl?=
 =?utf-8?B?eHhxS1ZHenVOUEUzYmRDcGtlRFRDWWwxK1dMTy82UUMxOWUxRDFQZ3hCR1NC?=
 =?utf-8?B?NW05b0ovUjQxbExUNytwZ0ZxdFh4bVJhcFFSQlNERXJFa2xRMGJ1UzBDUWps?=
 =?utf-8?B?YnEzTlhabkwzNjUySkNnZm45aGdIMHEvNGl0SVUzYkhBU1JDRTRxQzRJYkF3?=
 =?utf-8?B?YndlYVAweVpITVBsNWxiTjVxNVBCR2NoMmVjczZFY1dOMXNkcS9wUEYyOWJ1?=
 =?utf-8?B?OW5EYVprUEE3TmgyZzR6UjQwc29EdG5wN1p0U2xnUFdwd2VscjF2ZEg1bFdC?=
 =?utf-8?B?OE0rY2pnajRSN0ZiVlFRUVM5MWJ2cFhtRTlab3JNTHJIelkxS0lXZDhTSzVM?=
 =?utf-8?B?a0xNL2srMWwxbUNGdkN5amgvT2pLc083N0NkaFBDTWJ2VEJ3RXJzbEpHcTh3?=
 =?utf-8?B?d0VQVC80RnZBbFJyWlViR0loeTMwbHFoYXQraWtMTWRsTU1mQUU5VGRNWldM?=
 =?utf-8?B?amd0NXBNOHJVeXBIclUwaGMyQlhzZkVzUjkwVmx3R3BMdnB6SVlTa2UzU29h?=
 =?utf-8?B?Sm9mTnFsNUQwZ2RySHNEUTFRVkl0TTlyMGVxUWg3Zms3MXg3b3hNdDUyd1NF?=
 =?utf-8?B?b0RxVFA1Z1MvYndhR1hWakkvVlNXcW5UMERmakx5Z2lPakpjcE1pdzY2N2NC?=
 =?utf-8?B?M0JHS0IrOWo0VzlHTW1VY2NURTZSL1d3WUtrcm05QVJVbDAwM3MvcWtrUFJo?=
 =?utf-8?B?RStVU3NHbFdiOTRUOW95V3ExdmZlWExuT25zbEE1K2RqSHVnWnUydVpibFFa?=
 =?utf-8?B?WFdkNHg5Q3BZdFR4WHV6L0kxTkR2N3pRWmRFQ1EyMmY3Zm5tOUJWeEVOelY1?=
 =?utf-8?B?N0QrVEtVZTRXL25zMjIvTjZHVGNzQU0rR29WdG5UOFB2WUxKYmJLYnB2RFhk?=
 =?utf-8?B?THRnUVNpTDlpKzE1YkJ0b0c5YWZFaHlUU1NNNTh2WUNzTHYwTGtzSmp0ZE94?=
 =?utf-8?Q?Lpke3W+yPuTPPq+3d+xJ9sY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D688D2BD98C9A4A9B6C8B50ECA4C1F0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b54f9112-62f8-47af-8331-08dab804eb84
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 10:20:49.6900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HWsku5Ce68TNE3Ng5TqIkuElXjOpKH53yBhMSRXkys5BGDxe4d0nfcb4zI+Z/EvpyWewHQeZ+53URb7ELNYo/cUJ9gEZa316SoF4cGpCuGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5524
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
