Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85A26CAC95
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Mar 2023 20:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjC0SCY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 14:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjC0SCQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 14:02:16 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC9B30EE
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 11:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679940135; x=1711476135;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qML04MqPPbnmwdb267i8R5Eo6XtN5YTe8b9YnYpdnXI=;
  b=kmdWd4+4mx96k1JXINC6MAwWEz+476070iLALAgzKjzepZUVKUxesovM
   2lLGQo2S4Dfk5rkrZRCA1F3gPkw2tMn8qHANpoV/2KilfXeZ8i4u+Z7y9
   HjDonPdxp0yiRD2WXJTVKg8EUeHwHv2yeL2kc61Sb/X0QI3/l8yY69EpU
   YjlgOHbdm8hp2qElKYoLG1piC3phCd+kb2iFqV6NN+WMnIi4/qM63kPks
   ZKBxq/QGtCM9pUyLb19bUYZox7k2yuWxRdN4aVaZq4Iu56o85lndFDXWO
   IR9TLsI7rXJOtRrpfMyrdPhw55KVH9QZJ0pFp30GqYTiQwWUfXHV4hBGB
   A==;
X-IronPort-AV: E=Sophos;i="5.98,295,1673884800"; 
   d="scan'208";a="338688530"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2023 02:02:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrjA3xhz2SXtnmXbo9XvYXkuQNG4TmFqvv+6bNoba6R05hBLBw3N6jzAB19lpVokgPwLy2ws5P6FWQ/E3qSYV9pi93RjQeOaT5hn06wfAOV/RDEJ+jyN8te1AcVd4023eUeFkc53vl2KQUON/J0ZUknbhM7lMbR2zgsY1k1XwsB8s1tYo2slaI+WXpSxFZHuvzVAniqy51hXV/+zHqctxUnFASvdSLO2ZxxkQgVijUZx2KGZPrksNoQQHR2koYKlY2d9Qr77m7HnufpD/B16v+iz0EBJfzoieZlFLsMOvwVKKkfWnot43eiZfua8qj9/FdVpuQtye3j5v9fhGkylhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qML04MqPPbnmwdb267i8R5Eo6XtN5YTe8b9YnYpdnXI=;
 b=WabloXAb9Olnq2MaCIToGj28i5HqFxSAEpA+NtZNa+2Pn5yDqu3TzL5/VbHZslq0lKrpwMIY9VZo6FCpTWISehSyXa1rsA/mNfE2hWm5bGJXQPFvmYtBTaRoDKFbb+TEI2qhdwV0OLQLn60QueV5arqEvS2xRu7Q0W1Y6WGAfMv59tz3B7qJWFXssDuUTiaLMwfgC0Ou9jPA2gKk8kNJlVZfYjf49j+qOTJDjYUzEbdALM9ldfdiRI0iSJYaiUkvw9CJPUXn/rzgpwwKmpLdVn3oyzD6wBeLN/JSxG0XdP8q1I/EVFNJgWuQ3cpsLbDK1+SZlifLtnlSqLGPstHWtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qML04MqPPbnmwdb267i8R5Eo6XtN5YTe8b9YnYpdnXI=;
 b=J1fxjb07h+9lpLdP8VxpuRP3YKK0sj0eg7nc8pXwnWe4vNDK5NXfXgTy8pozrljcqcx6PrS2p03dwoZalF+Ocz8J+5hCZK2aBdqbqR0vJG2tdNaWvKsqW2W3oh0ILt63CNmm3yPa/d3SA+hhkbJ0YoW53ZG47f2XofrvZrVeId8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB6449.namprd04.prod.outlook.com (2603:10b6:408:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 18:02:11 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f73b:be83:d517:ebcb]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f73b:be83:d517:ebcb%3]) with mapi id 15.20.6222.028; Mon, 27 Mar 2023
 18:02:10 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "hch@infradead.org" <hch@infradead.org>
CC:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v4 04/13] btrfs: introduce a new helper to submit write
 bio for scrub
Thread-Topic: [PATCH v4 04/13] btrfs: introduce a new helper to submit write
 bio for scrub
Thread-Index: AQHZX9MlDGJ1q0eoS0+IsqlEZDxIDq8N/TWAgAANYwCAAA4NgIAAKb6AgACqdYA=
Date:   Mon, 27 Mar 2023 18:02:10 +0000
Message-ID: <95781751-73b5-7b80-6b1a-777016c390cd@wdc.com>
References: <cover.1679826088.git.wqu@suse.com>
 <72f4fa26c35f2e649bc562a80a40955d745f1118.1679826088.git.wqu@suse.com>
 <ZCERG/+o6515r06h@infradead.org>
 <a9efa03d-2472-db26-ebb0-dd6b21991863@gmx.com>
 <ZCEoHxLZ6KWXMlKu@infradead.org>
 <fb12ae46-dca1-d883-f170-955e59eebd18@gmx.com>
In-Reply-To: <fb12ae46-dca1-d883-f170-955e59eebd18@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN8PR04MB6449:EE_
x-ms-office365-filtering-correlation-id: 86843290-187b-4694-c5fb-08db2eed6317
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VD0kI4eSQ/uHTtbFnnJt0UhGd240ukoiIJx/jh1SQQxFPt58P+X3JaddY8sjX8uEgJWo4ZF9XJlqDIQ3PtVXS9Ce7K2UCX3pA12qFNIXT/JCntjy09EgVA/jsV2SYstS7XeFsUjXmUtDWHFX1vBOSD1D3smtbGGJaQzgPPQ722XsvcimBUuGrrtvGGkHmjvvR1+7F3YeQ57w1JqYXmjhlkhp1MYB6ja/jTpha2LrM49torCJnmglZyQO+hn8ZArPH7Zbw5rDpck9OQ18LBDG4b0irZdwdbFGR82BMAjLSs5nZwMYXPHtIzgAoulx3bIthLzhXwUTVnnQm849NxUZw5CX9k75V/Uc1dd4T6KJLPvj1DKXrLUiDMCuzgIOg0qiNlWNQB5+xQUizQuhMPJTUGGOuW5BSNB8A9IitG2lapUWcBmJjJMEMoKuUFR86vE0Hjw6chHpm3NY7Mj1N0FZdvD5pUh+TSPihQHDKa0N/YGDB6d2883uKDKRWIlBWfZvYqsex8gyXQ18MUCdbEB3lYc0hB10sb3+RW+c0asBPhWQbl45MWr2gWN+Qf6xBLT5WhhM/8vQ+QwNxzuNgNLN25exoFSl9eUqldci3476PIy/wEW2vbtXeXjmvUvivrLDsduj2Zu4pWKsPKAq5xH/0uvXv12o+0EnJZ+0ZyOLszYoYf+3tqM3fs0K1O8y9h9N
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199021)(54906003)(64756008)(71200400001)(5660300002)(8936002)(91956017)(66946007)(478600001)(66556008)(66446008)(76116006)(66476007)(110136005)(316002)(41300700001)(4326008)(8676002)(6486002)(31686004)(2906002)(83380400001)(53546011)(6506007)(186003)(6512007)(122000001)(2616005)(36756003)(38100700002)(82960400001)(31696002)(38070700005)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OCtoN2NZSzVsUnY0K0xxT25KNlNpUU9oNklUTnRQTUxHZEJmT1JNQkx1aWpC?=
 =?utf-8?B?Y083blRFQzlHdDFlOWJCWlFNZHE0M2JrTjJnbkFnUVpKdVg2N1JqOXdxUzZ4?=
 =?utf-8?B?TmRJeXVmZDNaVklWVTluMGVobkxkQlpnQitpaDFpZE52OE0rU0dTYjlIUHVD?=
 =?utf-8?B?VThtaDE4QUZBdEZWdlhEQzRXVVYzQWl3aFR4V1VuVzVQWDlYa2N5QWtSWm5K?=
 =?utf-8?B?SE9iNzJUM3ZZekpVYklMVFYyT05GVjg3aWlTdDhVdjJJKzFLdVBJOHduRGZ0?=
 =?utf-8?B?OSttYjNURTVXd3lGa3drbEhzbXFlRUlIYSttRGFaRStoOEw3MFpFUjlTTUxJ?=
 =?utf-8?B?c3V3WFJIbGdoY240cit0N1hsY0tUd0hQeVRsOXhoWGVESVk4UTNpODFGbnB4?=
 =?utf-8?B?ZzQwRURmTXNoVDJJMW0xY3JhZnV1eTJXaCtIbUY4enE4MW1qSThoTFZZMWpH?=
 =?utf-8?B?dXp3REcrVDE0aDhaMktjcCtDeDFPeUNaTmxkZ2wweTQ2N2IvZDJHa253Sk44?=
 =?utf-8?B?bm4za05veDBicjBWeWdROWF3dmFvTUZNVmt6N3FpY1RBYmNPakJQOEllTkJx?=
 =?utf-8?B?L3hoMjN1M2ZPWjRZUmRkUnc0NEVXV096Q0xMMEVaRzJoZjhXZzE2TG5RYURH?=
 =?utf-8?B?LzdDenlqem5UQ0RvclZrdkVZUmUyRWx6dVZCaml1c1N5M3BjdTZaWjhoa3hC?=
 =?utf-8?B?dzdzWnpJOEphY2diQ3h3bmQzVGt5OEovbXJqcGxnY0RlcSszdDRBeStWN2xP?=
 =?utf-8?B?TEp5YW5pY2dTSFVQMERLZzAyKytVZFh4SWRrUnJjM1VnbjlYblR3VnMzWEdJ?=
 =?utf-8?B?RFlkYmFQdDRWbVRFTmJFcjlZMEQ3aVNKM01qL3llcVh1ZTZZblA1ZU9WNWF3?=
 =?utf-8?B?RzRPQk01dTYxL0lWNjRENjFZeXJjMVFvNGQ0eHBmNzZ4RDg4ZmVIM3VodTV3?=
 =?utf-8?B?RGRERUdsZG9EczV6dzZ1dklhZjVXVmMwSElIa1pEZWFSTkNMZCtQc2x1b09l?=
 =?utf-8?B?MEF0K0hIOGJBbFNPT0w5bnBOVVQyeDU1clArckNUTnpEWkNjKytoYXNpalZU?=
 =?utf-8?B?VHRLT2JYU2tXMWJsK3BtZ0hiTzlIc1d5aG41eGRETmEzem1ubUpwVnZIQVpw?=
 =?utf-8?B?ZWlvUFc4L2MzSHdCMTdnZzR6MHZKOUJNbjJHcWRJZklzNU5HMXZsZVZCTkVm?=
 =?utf-8?B?TVZneEhDek5kVVNCTmh1OUJxMFI5WE1JMGtIaXRScXFUWUs5bUhJOURzWlJN?=
 =?utf-8?B?ZmR1S2QxeWJKS29tVEd2dzNjemtpbEdxT0FMblZWNEQyTXhSdlNBc3B6NVNq?=
 =?utf-8?B?L2xDRjA0VDNIYmxDV0ZNeHhXNlM1YXVkMTlOaGlZdWZEdTc5eForSFlZSGhO?=
 =?utf-8?B?UDVEbG1kL1p6aDFZbFNvLzdMM3ZpSkxxZzBpcGV4Z0h4WUtULzM4ZUpoOWhx?=
 =?utf-8?B?UmJKcHBqMThtOEpwSUkxRDBvdmtnb3gzOFVzTjFwYlRIcUFHSFRZWEQxMWQ5?=
 =?utf-8?B?UGl0amNwMVZqZlIyZmRBU1c5aDlRMnJUcVZzZ1RLNEZBMUVyWEE0dnpXNXFt?=
 =?utf-8?B?RHQ3aWNOL3pkdUk0dStVR3pGcmNNZXlJT1c3N1Brc3BYTVJDd0N3c2FlRE9q?=
 =?utf-8?B?ejA0Z3pXTHhyYktVS0xIUitkTjVjSlZCZldXTGh3WjZTUENnNU1uUjhSVkxX?=
 =?utf-8?B?cklXUjRBVTAvQWNvRzRMMW9hRHJvalB0VzM1cGZabjNSc01qZlg2b01wTnk5?=
 =?utf-8?B?d1JBVnZHMTF1VFk5RnBGN3lNMzNObE0vbXM2SnYxVlJHRjFEVFZCL0hDakt0?=
 =?utf-8?B?WThkVDh1c3BSS2tiQm5XeGtHSmFHdGl3QU5ONVpYZGVhRnZ6N2JoWmFtNDk0?=
 =?utf-8?B?NHFBSXllbWpiOEhYb0NTUlZrZVNIVzV4VmhYOHVIU3RudDhMbEhLeVUvYkNI?=
 =?utf-8?B?NWJJWmNSelNuODdXS2k0YnZlakJSRDR6dCtlYkpLV1JvdTlIeGRRUHBWaVJX?=
 =?utf-8?B?N0JsNHZRUjVlbldMU0dPOEJvc25qOHlDNFY3Sm5Cc3Zra2Y2QWlBa0U0NUhF?=
 =?utf-8?B?OUt4SkdZTmljdVlGZzBDN1FGdjNacGZmWnFuT1BEYThWVFd1M3VNaERwa2Ux?=
 =?utf-8?B?SXlaenl1eEpJV2NRdE4xbW1sQ1lMMVpkUHBwUjQrM2NEc0d4ajNHaEJycVpF?=
 =?utf-8?B?YStZSEdHaHAwa2dXN1F1VVFlcmd4bGo2TG93S1hwVDlBMDJkTGtha2FnNGow?=
 =?utf-8?B?Z290dkE3YndJWXI1OXFueUxGRFpRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71B820BF48CCDE4381942B11AB278521@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /GClcPtU7Qb3cQWV8XD92fkGHkim9BmxEALDlQFybUCksMDjvCIR/zropp15rUQxeCbZj+hOs8EFlM0KXE0rlHV4p/tJ9l9ERmiAeIp+34w8lVHbjyNR4fzdKDx8e/oli+6Nzt09nZksxV/ui0qxN3gnkvdU1uV2NpJC4ZODI3i1dgyoCnPCozvtyXLZONVmQYtULI9Ug86dRuJeNgeqsdIqoUkfbR/RWG337nWJjnQGjQSLRS+JPfAcE0dQTpTJGa0UqLF6CPXFm9qnN4ioeSxzaD1yy5adOtk+0EgVGnznvhglEW5vWHG1a1LE2zbJtY92QVZXXPWik4cPh95wfcpFlbAwBtruyiaLisZ3hbiZN/8t1UXjBySDxZcHqsmCDJXCajBiQ9z2rHIzDA6p6S2s2rGRI2wCLxqlzMWrPHQ1rmDTaPMq4QnjuhdF79OOe+HsCEgSEuXflS2Q17bPaqPdsHaWrqjPtH192TlBIHk9ZE/N/nIXtJDqjGUUT8QLiTrjSxCYs6EvyAreLUL7PwzhEu9fn6KZXcDyFTOyBCLOi3sXPUc2hUJqrpmiTzM485Jau+e9StorRnJDuBgk3mmbqmnzAB+8oYCEva2F/ZQLdXZTvkbWOr1HMP+8tk5BJLEAC9s7L7yis7AXGqpQi3P02oIKYiFmHOX2WTK/Uhrq22mlWWew9znR7R0hPg4A2RYdSSpibEcgPwC9Zy1G6lsMmSeqFvBBLd2R47f2Il6WAeFIbNZ8VBJkyOLIowM7tRk+ZyXsrextJaaE/tLl11bBLC0pKV6s/MFpRA6G/w0kfIOr+T+gPCDMQMLBV5gU636amJeX6rlFMqWeUlkD8E9C6hIS8qM+DF4aseHZvec=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86843290-187b-4694-c5fb-08db2eed6317
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 18:02:10.7233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jnIBZWTC7Ef1QpI894s/b5xStybq2vxQjnBeu5vCFmD5DwHg1iJ6pcr5I0LKtzd229YaTdAEGBDNg+9lsQeFA+o/P1f0zFPMhaoG+eZpGx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6449
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjcuMDMuMjMgMDk6NTIsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiBPbiAyMDIzLzMv
MjcgMTM6MjIsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPj4gT24gTW9uLCBNYXIgMjcsIDIw
MjMgYXQgMTI6MzI6MjJQTSArMDgwMCwgUXUgV2VucnVvIHdyb3RlOg0KPj4+PiBOb3QgY3Jvc3Np
bmcgdGhlIHN0cmlwZSBib3VuZGFyeSBpcyBub3QgZW5vdWdoLCBmb3Igem9uZSBhcHBlbmQgaXQN
Cj4+Pj4gYWxzbyBtdXN0IG5vdCBjcm9zcyB0aGUgem9uZSBhcHBlbmQgbGltaXQsIHdoaWNoIChh
dCBsZWFzdCBpbiB0aGVvcnkpDQo+Pj4+IGNhbiBiZSBhcmJpdHJhcmlseSBzbWFsbC4NCj4+Pg0K
Pj4+IERvIHlvdSBtZWFuIHRoYXQgd2UgY2FuIGhhdmUgc29tZSByZWFsIHpvbmUgYXBwZW5kIGxp
bWl0IHdoaWNoIGlzIGV2ZW4NCj4+PiBzbWFsbGVyIHRoYW4gNjRLPw0KPj4+DQo+Pj4gSWYgc28s
IHRoZW4gdGhlIHdyaXRlIGhlbHBlciBjYW4gYmUgbW9yZSBjb21wbGV4IHRoYW4gSSB0aG91Z2h0
Li4uDQo+Pg0KPj4gSW4gdGhlb3J5IGl0IGNhbiBiZSBhcyBzbWFsbCBhcyBhIHNpbmdsZSBMQkEu
ICBJdCBtaWdodCBtYWtlIHNlbnNlDQo+PiB0byByZXF1aXJlIGEgbWluaW11bSBvZiA2NGsgZm9y
IGJ0cmZzLCBhbmQgcmVqZWN0IHRoZSB3cml0YWJsZSBtb3VudA0KPj4gaWYgaXQgaXMgbm90LCBh
cyBhIGRldmljZSB3aXRoIGp1c3QgYSA2NGsgem9uZSBhcHBlbmQgbGltaXQgb3Igc21hbGxlcg0K
Pj4gd291bGQgYmUgcmVhbGx5IGhvcnJpYmxlIHRvIHVzZSBhbnl3YXkuDQo+IA0KPiBUaGUgcmVq
ZWN0aW9uIG1ldGhvZCBzb3VuZHMgdmVyeSByZWFzb25hYmxlIHRvIG1lLg0KPiANCj4gQWx0aG91
Z2ggSSdkIHByZWZlciBzb21lIGZlZWRiYWNrIGZyb20gSm9oYW5uZXMgb24gdGhlIHJlYWwgd29y
bGQgDQo+IHZhbHVlcywgYW5kIGlmIHBvc3NpYmxlIGxldCB0aGUgem9uZWQgZ3V5cyBzdWJtaXQg
dGhlIHBhdGNoLg0KPiANCg0KU3VyZSByZWplY3Rpbmcgc3ViIDY0ayBaQSBsaW1pdHMgc291bmRz
IHJlYXNvbmFibGUgdG8gbWUgYXMgd2VsbC4NCkkgY2FuIGNyYWZ0IGEgcGF0Y2ggaWYgeW91IHdh
bnQuDQoNCj4gSSBoYXZlbid0IHlldCBidWlsZCBteSBWTXMgdG8gcnVuIFpOUyB0ZXN0cy4NCj4g
DQo+IEFub3RoZXIgdGhpbmcgaXMsIGlmIHdlIHdhbnQgdG8gaW1wbGVtZW50IHRoZSByZWplY3Rp
b24gYmVmb3JlIHRoZSANCj4gcmV3b3JrZWQgc2NydWIsIHRoZSB0aHJlc2hvbGQgd291bGQgYmUg
MTI4SywgYXMgdGhhdCdzIHRoZSBiaW8gc2l6ZSANCj4gbGltaXQgZm9yIHRoZSBvbGQgc2NydWIg
Y29kZS4NCj4gDQo+IFRoYW5rcywNCj4gUXUNCj4gDQoNCg==
