Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC327B7F89
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 14:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242443AbjJDMok (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 08:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242439AbjJDMoi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 08:44:38 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A03A1;
        Wed,  4 Oct 2023 05:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696423476; x=1727959476;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ikcKTa3ULeW/RC8x1xRpHG+rzCh6pySc2XfzHuw6fro=;
  b=csxFl/+hWfg4vRjLqXxKxfib2ckwUSNJXwAv+kLCykVWekcfDT/2j8cN
   OG5OO6mo/PIrLJVUNQ4mQ8jpb7p3AfY3O1Z9F1iL2AQ1VnjR3mfiqru6q
   WDVkq9s0b+EglhAFJgmXcWtWmMWlk+NNz0hIbhqRoN3ZCppGElqijNSdF
   d0Txyr+73Kgq1fodxKeh5m01NKd7WYUeSw0J9owzxI4AKm5vQmZccondo
   GF2LNLI5ZuXEu6OQBv6BAaz0GoFC2rPYaoAzunJ/tGIznTykxI2KVwWgq
   OYLWehdMDZIFywzLCWccW4B3OuWDXuwjHXBTwZ8jhHnWy88P5IyMqD05R
   A==;
X-CSE-ConnectionGUID: KL4wHabUSZSrYc9P+m/b7A==
X-CSE-MsgGUID: zNIuHlerQGqu+iLrrICu/g==
X-IronPort-AV: E=Sophos;i="6.03,200,1694707200"; 
   d="scan'208";a="245977504"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2023 20:44:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLAPZ6H0IAgkP6X4xa6m+9oakEXLfF9/jRxoMqgczRuwzQv6pmL6a6BpbyV8oN0gnXzcGHc/gi6tm3WCX07GMAUFMbo60PQxEL59PY5GPmufJ+gHXDqQ3uDMzahgn1Bm/wnADfVZXRb9HO+n3JyURhVLrZNpv6/vpVQJA8yXedCi4j0Ft4neu/jVY8Bi4SnT7vQsxBcqY3Bm9hUI7a/sdxFA+GxLXsLJZSLpFrnLR3l8sY80CBsps3WOj7Ot8angaswQOogcpghRaqledySd3JAr0B2kH4/UQHEt79HGf5Rv8HqDAtSg5lyz0iDHgcp7G9ttIwrbJm7bZHrosUU+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikcKTa3ULeW/RC8x1xRpHG+rzCh6pySc2XfzHuw6fro=;
 b=F1Y3a3dSxu5ZxcBs8k+vNF2LaHi3yBlHgnZ3pdn9UMDfW+V7defPCw4WcOvvZ7fnmw09EU3/DS1FwkNtG/cs0FebxWPqfnZDDdnWrWVdYtP/vZAOGU+qmIOp+EPPhxdaLd7z40wyf+bOgiS39ss0GHg6e6+caxDf1vdixZGoPG+FwFJimEvgM+JdcYZs0Ja4IiUMnjK4mns31q0p+ZN2GbVSpYTvVsLoXAz2OQUpqMHBgKrvrBGC/QAQU1QaQvZu6T5F8KUwLs+J5TlA1UkIH0obGKobM1lyk+Tik7cKoWqJR8xWBljKgO8D5/uunlEqz++9Wg/m9a/8WlY9Sv64Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikcKTa3ULeW/RC8x1xRpHG+rzCh6pySc2XfzHuw6fro=;
 b=x2t1csnp/N5Zlr0km8QZzxy3DnVqog0ZHZ4apxvqBKuBS/QdRIW9fgWV3D7qAngUE0Rv9roDRi6hPhOiAdcXx/afmrDElLQYzhTbu5vH4BeB+wH1f2D5sNNPE3lAm5//2rgMIosuHGyl7eBlkNWmyU8j5prstamyK58z2z3JSnQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8508.namprd04.prod.outlook.com (2603:10b6:510:2be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.39; Wed, 4 Oct
 2023 12:44:33 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6863.019; Wed, 4 Oct 2023
 12:44:33 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Qu Wenru <wqu@suse.com>, Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] btrfs: remove raid stride length in tree printer
Thread-Topic: [PATCH v3 3/4] btrfs: remove raid stride length in tree printer
Thread-Index: AQHZ9phKggEwQVqJEEGcR8MCAs47mrA5k9oA
Date:   Wed, 4 Oct 2023 12:44:33 +0000
Message-ID: <482d1555-5c40-4448-836a-17e42549292f@wdc.com>
References: <20231004-rst-updates-v3-0-7729c4474ade@wdc.com>
 <20231004-rst-updates-v3-3-7729c4474ade@wdc.com>
In-Reply-To: <20231004-rst-updates-v3-3-7729c4474ade@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8508:EE_
x-ms-office365-filtering-correlation-id: a60efd12-231b-44d9-3513-08dbc4d7a8c9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jUyfi7OG+/2KasoaroWuWqBfsK/whHDOn3YoW9bf/rqpx9vAsu6D4F1tgeodyvSpJ2R5iLSryEzslz7q0th1ow9ieYoSovon28cxmljg42hbHZ6v8lfzEZGmuGalvwwAQhCLfldTwRYnkof+XYXjb9qnl/vHJuie0H+PTtEhSoddWF3IUeyrNcPdQUfKXcbC1kc6DNFQtbNgdHwB76LmQsUBy0srk73SDMHkesGRclzdok/ln8xrfAFb/8yRonJSUZ9aSnyqwfMnkVir7mop2y6QSgevwaIHKx8qLGZqCHTugT0sbo9VPLlbgI8MacDsaAZnhOobOYw1zKLW8x+Ae2SZLFdYAB0WclwuYq7r7SicAEwK8o1mOBfdM7UH3b/xsVPIhgMHKaRPdqtKLgf6wwGU7DC1EazYwrnmOxIfYx6Du7oZ/Ao+Cttefx8Rq1cXlmALzoNOIICfLlsTO7ZIjXvaX7fHxkkhX7umbOWq7xc/jWfhSrXvv61MkOW/82/+Oo7ih7IX0qQWsNT7HXbR7auZrMOUzonCoKoHaOzzf98rrAioh/npZlOVNt6MZJaw/EOOSjYbGAYPnZL4RiocRpgsgJ4bieNtTqy5i5KcGG3Y2mZApkfiYLyJECe4DqesfMwdjzF1CEaxc/ZFmCTvX3YiTrGdSEyG4dFmrtuOOgjjqAGhRneHc55E/A8FCWNB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(31686004)(478600001)(6486002)(6506007)(71200400001)(38100700002)(558084003)(86362001)(122000001)(38070700005)(82960400001)(31696002)(2906002)(316002)(5660300002)(8936002)(2616005)(26005)(66946007)(6512007)(41300700001)(54906003)(8676002)(36756003)(76116006)(66556008)(4326008)(110136005)(64756008)(66446008)(91956017)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTZVZ1ZqQ3E2aDZvditwcjNXanFRTnFVNUNLcU5JZEVKSFBRcWFYYVAyS2cr?=
 =?utf-8?B?RitMR0gzSUZLZmd5QWNpeUtaVXM0QTNDYVdQdEwwZmZUWVhPc0J0RXQ1Wkkr?=
 =?utf-8?B?dFM2aW15RG0yNjIvVnY4aHo5NEZ2N00xNDQzOFVlcEVxb3RjR2oyWkRheUtO?=
 =?utf-8?B?cmc5aXZ5UzB1YjRBS2g5Z0dBdmt5SmZSbWd5TFRKYlBBbEdob2d3TU9TRU14?=
 =?utf-8?B?RTZZa051VVVSWW1McExUWEtvdEhReno2MDRNcW9wREp3aTZLam9hSnpkbk1n?=
 =?utf-8?B?cVoyenl4a1hFSzNGMUtWQ3VkcHBvcjErT3NaNGVCd0VCa2t0dEVIVStFQ3JD?=
 =?utf-8?B?QjYxM0x3NEtXOUR1L0dNUmtjN0QydW1TckNzbHVQRVB3UnNPTm00SkttMWpP?=
 =?utf-8?B?aUNoVWw2Sml4UEJJK2k0cUZsR3REZ2J3YlAzdk4yYnl6b0dmUGxZeXJYOFhl?=
 =?utf-8?B?N1BEWWlIZXJad09LWWxEaXV1REliTmNDaGxNeHlQQTVzaFBYOTV0a0NseTdS?=
 =?utf-8?B?bGU4QzkvRFJFS3V2OXVIZStSWVV6RTlDd25aRjZ5bkdSY3JTSEs5U3hsdUM1?=
 =?utf-8?B?SFJUa1ozT09DY0hRWlovVVdwTWQ1Q01MVElYSHgvbGFHckZXVno4RVhjTlpQ?=
 =?utf-8?B?K1NheWFtV21ueWxhemFOcFZDQUNEdTlBa3B1RUh2RDhGUmc4QzBWblQ0L0l4?=
 =?utf-8?B?WVlwYTkwT0pFdlFiUWdQZ2dSZFhiOHpQU3BRZVVXU2pCU2FKckxyMnV1dmt3?=
 =?utf-8?B?UVYrR2tZRkd2Tzd1V1ZqQjVCU1ZudlV5dUZDbUpGL0FwWnY4a0JUQmNxSUtE?=
 =?utf-8?B?eTJhQXhwZ25SWXAyRGdpcEtZSEEwSUJETlp3NVRaY0M2bnUzWUE0a0VidnF0?=
 =?utf-8?B?KzR2RWxkOHhsaExTNE5WMGNidTZnS1dadXAxVFdrWUh4VGQ1NUtRRUZBd2pJ?=
 =?utf-8?B?d0VJOU4vMUk3UzJPenR6cFJERFVmQm5CV2lNaExTeTdrV0czdnNuckJhVkdN?=
 =?utf-8?B?WFZ4aTNFRGV2VERnV0I1NjdkbUJacWdHOFZnaEFPeFYyRTAwUVplaHhKR1Ru?=
 =?utf-8?B?UmczTnAyU2RFMExINCtSeDh1NmhTem5Uell4VTJLbUtURkEzT2Rnb1NkRytR?=
 =?utf-8?B?SVhrdHJzeUVSZTdwRlJORzJoR2FtQjZScWJiSkRCWGVadjQwVTBlbDJ0SVpJ?=
 =?utf-8?B?aHNsYU1VcDRvUW90OHJiRFg2QWF0QUtOWndjSTQxa25sUG01MlhBZ0JSaG1i?=
 =?utf-8?B?eFhYOEtDbk5vOWQyWW55TXFlTGhGTGhiUzFBYUVIaGxhWW5DWVd1N3FJVll1?=
 =?utf-8?B?d3ByRUFBOWlZMFV0UjFOaGhBaS9QVS82NWZVWlFseEVacFk3VDAvcVR4YjE4?=
 =?utf-8?B?YUl2WmhDMzlrNG1jeHVEbFVlYytWcWlBcDdrVDV5Rlppc1VLcVJGN3lHKzVG?=
 =?utf-8?B?NlBuNC96VnJKWWhCbUkrOUFYY1d5eHR1WjkyQXhVWE9XK0UyaFZHdkZ2MDVF?=
 =?utf-8?B?K3BBWE1LTVQ1ZjRGWEoyTVFjNU45NGFVd1IyZ1hZUnJ3K0ltdHpoTUl2eTB3?=
 =?utf-8?B?R3VUa0RhR1JsNkZRZFUwSTBIYkxhUWh4KzdMMzVSOENwWVNieVpMNmMrSTdF?=
 =?utf-8?B?K1JqVkY3Z0lqM2Y3VHIreGY3SHU4YmlFV0hEaFlQOG1mMDY0bjJ5OVRob0xB?=
 =?utf-8?B?T1ppL2J1c3hGdkVMdU5HWTM0RC90SDU3Rm5adnBEYVpMS3Rpak53K0NDVVJT?=
 =?utf-8?B?ckdLa3BVUHFvZUNyUSsveTdvUFRGUzdpTHNtcmZoenlYeUNZRGJSL2h0Wmh0?=
 =?utf-8?B?NXJoL2ZLcStHa1piSFBsK1VMelpDL3ZBaGk2Qm1MRmNaOVpIaTNJWEphYW9W?=
 =?utf-8?B?dFFtZGpSRVh2Vkx1Ulh1RDB6Uk1KQk11ejVVWHBNWU80YTNRVVhJV0dtdlNU?=
 =?utf-8?B?cVhGdnM1cGliU3RmUnBPUlY2K1NxczdXNTJRdWpkemxHOFJYU2YyTFI2c3Bt?=
 =?utf-8?B?bFdVWHpJdEZXZ2NORHlXcFl2MkJWUEQzeWxWdzdYVEJXbFFIbCt6R05DSlVW?=
 =?utf-8?B?ckY5c090M3AxSzhLaDJGYTgzcHUzWmNoZkx3MmR4QzdCMys0bmxjR0wvY2Jt?=
 =?utf-8?B?R00zMXdqakJIZTZNalVpMi9oTElBNHZqcnE2MjlaQ0xyNE85ZWg3R1IrZHZ0?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C8EB9E87DBB4748B092FC62B1A4ABB6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UG/AGf1ab/A8OpB/t22eiKPmq69ALuSIJGV2zBzuC8eieUKazt+PALncOkzzzR6o2ZBb2JpB3xug+lrnxSpo44jzUl7nIhhci4GV3MNcZce707DDyfWvvhXeDer2p37nphLc83Qpe2i02CDOAdqjqkFYDSUFtddMTuKNfjVpEvcDk03TurzSzguNBEWRkf6go2uxqHTtsKXNhtjq6QXWEjkMDnA5XsYaduchFM86ZKQX0vtKJn9zsphghVkFIO6LonFKtraXRXfRLY56LGLeVLMYx1jRb0oT+AMMhiOXJPBJL4MLVvneklyzhPN97bvwAfvQNtMv8F2+pwSmO1EOH0hcpSzikkGdQBrhXLSJR3G5s/IHxyVTKd9R0PErxW3xCGjkNSyhN9yz6pWhC1ERLWcxzRC3Obcc7jkP5y4N2XEZQVqJYtsTb77vWh5mWutdjmHMJcT/gWGSuoByqLPKs+117NOs0ybte85MFNcdPwPjIB7SHU+yU66gFCJhsWx53FSByBJ/5w3PzEnZ+d9+8KAOqb1nXB/uFn3U6yiEEWbvg6L4cVCUGzLhilwmBIR8sjv0zI2jCX8k6K6VgZJZeJdeFXatC5F158y12MNozGMIweansbrZWga/RNKhDo0Yr8DVrsdWok5ApPkaiWN4wuxFcKVF6nJ1vPVGCJVTKI8rqNe53lOtDgmuQz6yn4dSvcsa4QPu2ZX2optiJ9qjn+cNjbuibJkqyvZgg76KcHybqX2+8zqKXu/qkKpAzvQVpju3AMQQFKIcQFm3PECmc0C4EpHf97ce+166mxywizafcFoKSLOik32tlOTwQy2dDjGZg7RIkWPiPmo1gg/UekV/f0A0O22I4i6BEyqsQhYMsQyM3paWghokOFxoTujSAEeMJheGtjUx1MsqrJMwNg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a60efd12-231b-44d9-3513-08dbc4d7a8c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 12:44:33.1650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ppuwPpHR9xHX10jBHOVOp4hdaiuOTfdps6jAT2I93z/USnKH+yLp5NDW3kO9OQip7ze5T4B8BL5SxGXiSdlZ6xFC5yZAXrLAF+YAhQvIKjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8508
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Rml4ZXM6IDM4MGJmNjA5NTZmNCAoImJ0cmZzOiBhZGQgcmFpZCBzdHJpcGUgdHJlZSBwcmV0dHkg
cHJpbnRlciIpDQo=
