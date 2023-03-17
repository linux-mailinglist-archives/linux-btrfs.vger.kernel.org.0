Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781AF6BE6FE
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Mar 2023 11:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjCQKjq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Mar 2023 06:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjCQKjo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Mar 2023 06:39:44 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C34567821
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Mar 2023 03:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679049583; x=1710585583;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PXTlSE6iO8J7eUd51KBbx4VOl/02DBkLVr+j/4KKmEI=;
  b=Onz2PLYzB6e1uA0/it+fkF2cc51GLVpwtwOrLuRckSNDgnAQobtpQqrp
   dcQpdaK+tyfmltet9A8q/HZxm7I1CKnlBUHSQyRSsitGg6oOnZVtr2Vj1
   2Y2lYXjkOKLBZ/bGEngu9KT9TaT+eqqdCWwageTLIevx46SoiBXEtcJQA
   go0YdEtFQMJKD7VL0wc3O8sjmTFlIO//1Tkb1kgUSxOT9Gm9EgWOp3a7B
   ehK2eJzgpNrRe4vwm2noPZ9xrliwVLs8uUmIxAjALZjpT3gYQfp1d9YKK
   oQViI/lVbOw6cb6vIxuQ9y5CnLH5vocdb3Z3pu/n5hVO1nQJTveYueZ5P
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,268,1673884800"; 
   d="scan'208";a="230818026"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2023 18:39:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDvPgSyIephpZOsOHUiFyw8jGPM/YZ4M9YbC/6IrTQ3RSWTA2WZtHpMjPWWCuzq12x+eCamQ5vtyQf0lmoi11CGTNXK600G3z83VTiXkyRZZQyg1J/WdPtJPg/XSBulzP6AAQomMKwuMXurB4fc3dI0EQDV6pLDnSEw1uXLaPIjCxfDEsciqX9yMfvr3TIZFU9wAGfIaPqyMABC9zTR8LlLkaY9J4QAGtDfrccQgtOks/X9uGA36Fc+zQDnQaAGb0nGlsEknWiAeISshG1QzmS7L44zquF4OJXm3JnLHSce74C5y1m73HvifEduoTjWT949OAGWOv4fgAWuV4atmQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXTlSE6iO8J7eUd51KBbx4VOl/02DBkLVr+j/4KKmEI=;
 b=h98szKojyXTHy5Pb6nXkDYTNeyEASg7uT1O9vbewF4jf5YQk91f6A+g2g7HSj2x3dNU9m0cXVcYdSXLYCFVgw41HKa33weh/lJdxtd8mm3wEBJHY9YdCLYEo1WmWv1n50xfNvbqjE9tzjIZN9ib/rIOwpDkjbcQgHdCovijI7RQZiG3sYEorYv5a27g4XFXABeOZ1B1YQZrsUMdGpV+KSBMUg75hP2QFVUaJmOVaz4p21JfcMOW2N6ZtLqsF7pu18rFLKRyHh9BHIZe1kjyyuD35ODvhPJwed/1f4N5WNxWTurfIOTNZdC0a7vN8WlLXRNIA2/znjmxbgoi+bHq4Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXTlSE6iO8J7eUd51KBbx4VOl/02DBkLVr+j/4KKmEI=;
 b=rIqC+MM66/0MLXv+CMco6XUF3PQPoL7IbypirOHU1IxOdzh8KivjXJyq1VxV0DXum+7I3pOCOcvdSADcd0tVZtFNoN6sUCqcCoi1dYyBBZ1saT4rQTfJWEr//PIIwmVI6/GZwKp1L6hWtWdy9hI+MaAFbs0vJyjHZogW0/pacNg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA2PR04MB7545.namprd04.prod.outlook.com (2603:10b6:806:14b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 10:39:41 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 10:39:41 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Johannes Thumshirn <jth@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: defer all write I/O completions to process context
Thread-Topic: defer all write I/O completions to process context
Thread-Index: AQHZVpZWaiFcc91+P0m/PgMZeK1lWq7+zGEA
Date:   Fri, 17 Mar 2023 10:39:41 +0000
Message-ID: <2502ff6d-a1fa-a8f4-fcc4-2d86660c089c@wdc.com>
References: <20230314165910.373347-1-hch@lst.de>
In-Reply-To: <20230314165910.373347-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA2PR04MB7545:EE_
x-ms-office365-filtering-correlation-id: eb266fe2-ea1f-40e7-695f-08db26d3ea44
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K5xj6OUCR90agk+T9rV2+8FyaRsL7UDVA0msFOmVuTADOV90Vxpl7r0v2Ur94Ggkd0GrBgyU+Hx56my0LCZK4/Olw+iQ1pYuysM5I9G9sqlW8SCmNZLcc2gFQW4jaSByg/dJ6k8ShK/3nBJ9g0ojUCtdb5bknZn3HaVBJ8IxKo8fBrwYNyDsP9mUhDvXDuTj3xuAAHzA67Jx6mauBpAJ4yF2niMOoYikXAzHeh+Sa7B5E3jrZ+MZQwrOKbntF3E6rRE52M7w8jYrddybYGsMdbGeV+9SCQYjraLTVC2rlzwiEmdEIgHMKA4XjFfBSqovB2TXPyqhoD9FXHVc9KwPfRFKXNXk9QLTJgHFeiAAqy5cG3SF9E4a0yQphF/ZBf5e9kscpDefLFCyny9hoIjn90A/5uAD4WhrKxCPUOS/lNghUxsFnn0Ax7iWGosWKfLVf34FXQr8nEhBd1HMD2Bw/eoLFgNunGnM4ugjKj16TtHBjPIaM4dg0qAXugQ18NUvOonxKe2i/edb017CHom4thiGJ/20ExwA7gwjFNZUXKA/2LoRb9JR/vnwe7cyFkulJcgZDe0xQU8rxfuvLG+dOxA9/J11qeXtQsXdPFiFC6Q3PRARpPXXhJwVg2HmRlxJgYJcCSEoeleAIaZ92j/85tRPcGMWXQQOHTDyaE9A/pVytfQbqr9MoEZpco918TuPONft3zsOOX7wfqGi9FbmUGTLhnMdSweCNo3LzaIWT/3YZH0ti0yluOQzAF2P5MYXYSFC79oNZ6Nx+NxloKs+bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199018)(66476007)(64756008)(41300700001)(36756003)(8936002)(8676002)(6506007)(66556008)(4326008)(6512007)(82960400001)(53546011)(66446008)(122000001)(2616005)(83380400001)(186003)(5660300002)(54906003)(110136005)(316002)(76116006)(86362001)(66946007)(38070700005)(31696002)(91956017)(2906002)(38100700002)(71200400001)(478600001)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0ducXNEOVZCTnZlbmg1dWRORGRLelhVN3hpc1dNOHFxd2p5aGgzUGpEZ0Fp?=
 =?utf-8?B?ckdIbkdJZWVvbU5UOHd2d2RxaExhYzlpVEJwQ1BZZzVZb2o1eGptQ1IwQ0Js?=
 =?utf-8?B?V1YwK0lmZGpxUEtLb1ZZZWd1MjBUQWRvWU1GTm5VNGU4WEFtUzdaYlNwQy9O?=
 =?utf-8?B?czQyUi9lakNLd1Z6TVg0MmE0M0dqU2ExT0FQdkp2RHBvNnpsRmF4WkM1ZXUx?=
 =?utf-8?B?YzU5a0hPa25ybWxpRGVOemllSzAycHMvWmIxMW8vallDcEhObFp4bWxsYmc1?=
 =?utf-8?B?a243eks4czZXVUN0b2xqRGh4SGxuYmE1NFl1eGFhKy9zNEw0dGJnZWhJOWxr?=
 =?utf-8?B?TTRUc09HMXV1Wi9RS3NKU2UrVEZ0V3RCdFdwQkFJUmVqWWFISTZIY2Rra1pU?=
 =?utf-8?B?bHhXcDMyMlMzUkxmOW5LR1o1RjNDVUdyaEd3NkZFR1M5cTVNQWZqcGIyaUJ2?=
 =?utf-8?B?bGNGalRhVEpQUWRXVDIvbndiNml2d3NyU0VxSmJxOTdCUDQ3eDNCTld1VUdO?=
 =?utf-8?B?WnZNTHYydDBUaDBwZ1VheThocWI2SkE0R1IyU1R6NHBrYSsrZWt3dVlwRkF2?=
 =?utf-8?B?cEg5dTFHYkVLTWV1eVdpQVFjOWNmNWFBYnpoYllraU9FQTVkSTBVVjh2YlFF?=
 =?utf-8?B?U3RIeHVsalY1RzloZXVsZlF5QjNWd0ZyVXVpTWdKbUJEanJpVEZMalBIenYr?=
 =?utf-8?B?VGNvM3cydlpTU3JVRGFVMG5HMlkwZTlIN0l0QVdlaG8rcXpGQy9VaHo4VHJy?=
 =?utf-8?B?bE9Ea2FFUGlHOTRhRCtRY3FrN1dSZlAxdHE3STd5b1J3YVA0L1UwemVhQWZk?=
 =?utf-8?B?LzNKQllGdUpsS1VMdWwvMk55Z2NiMTdDV3oySFM3WUplSWRJSlBwSm5uNkdL?=
 =?utf-8?B?SlV5dU9vcVZaMXc0QVdwdFUwRldmMDN6dFNITkJGN1E4OURlVWE1NjM2NTdr?=
 =?utf-8?B?WEFHRDFzbnhCNHIwaVVLZGRGSno2VU56MW1xdXF5cWlLaHZtOEh3aGZnSlJ6?=
 =?utf-8?B?SUlEUWpZcVdQZWVKT3dqTm9Ob29zYnVwNjJsOEoyeHZjMVRsaUk1OGtxQURv?=
 =?utf-8?B?b2x4ZElWekhzVHgxTmdyQUpDZEZKcy9rc1VNdFYrZ1VVR0NIbWJEM2Vsdzds?=
 =?utf-8?B?VWdQeEtwZDl0WVRkeUlSVTNqeVRNK1NXWlBMZ0FFT1c0VVVOc29lTWZybktD?=
 =?utf-8?B?SXZNRTV4UU5PTzUwemZpbUwzVVdSMEtWSkxCTERkY09CZlFLUVdLUVg1NHRQ?=
 =?utf-8?B?ZWs2WEhQUitYSUo5a0hRMnlzN0hYODdPKzY2WDFXVUZsVjRPbEdnQXZHVEJN?=
 =?utf-8?B?dStpY1VpTmtpSTZqeUF1VDVueDdJR21XSXBENWc4RFJSODU2TTRjeUFVdi9v?=
 =?utf-8?B?b0ZxTW1XVjdXaTBHL3BGL212aS9qb3NQQkFmbHh4REM2TjV3YkNqTWpyTDh4?=
 =?utf-8?B?WjUvZXNyUzk0YlRSU0RSY0FkeE8zZDRHSExtd2MwOFV5V3NMdHFrM0t2Zzhj?=
 =?utf-8?B?ZDR4T1hUN3Ixd2xmbkN1ZUt1Um1HVGlESXBNVzZISDZrMkNac21HamxKOVRO?=
 =?utf-8?B?cEN0K21McE8rUkpQWlRKS3E5c2tUM3U2YjVrZ2diSmY5WmdCMWhiSjliVjIy?=
 =?utf-8?B?dmpPZDkzd2o3QThDSytJbGk3NmxRZk1uK0ZuMkhwRDdCaEtqMUlIVERkdXNi?=
 =?utf-8?B?VzBEdkdseENKd0xJeEZPTmVxa1ZldkVqcHB0a3FuK2wzTUVFY3JBVndNR2Vm?=
 =?utf-8?B?RnBsSHpGdHVrdmJEZHd4ZWZnelI0WW5aSjM3R0M5WEtmZ0tsaFBRY3NHMEVP?=
 =?utf-8?B?V2xPMnZucnZMam80ZE92UmxublBhdGVZa2Y1OWUwVDk0YmsxZjJScEE5QTRZ?=
 =?utf-8?B?VHVlREpTcVdraWxOajJ0d0NHYnBIR3FxTzJqdjc0YmtmY2hiK1RYV0YzUkNY?=
 =?utf-8?B?aVR0ZlFnWEI3V3F2MU9PUjVmTTBMUlJGOVNlcE5QMHB0bmdaMFo0WHlGQ1dh?=
 =?utf-8?B?ME9adVlSdVZPYnpGb3Z6alRKbVZjYzU1UEdVWENVZFNTNjFWczA2dkMvTzg2?=
 =?utf-8?B?Mi9aMUF6UlJWWkx4SDJta1hKZzlUUDNhMGVwOXlTakk2NFQxbHA0dVFVbFFP?=
 =?utf-8?B?UkxFZTJNcWQza1UvUWcrSTdvK1l5a0ZoMUFTQmNTQ1Mxd2NFNE5rYlB6WDcx?=
 =?utf-8?B?OUpkY0prdHVuVnFEeS9JWUJwZ2NwM2NmVDlQVXZKTUZvV2JoSVVFUm9WOHdk?=
 =?utf-8?Q?+wOtVM2p20A4ga7Yd/Qo5SdOA7cnZdZn7VqZ5EqnqI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5C04068E715CA4281482046585FF10D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: X5rUzSbdg1FJOKfXlG0F0UJnOJQkRywUhU/mPLbJyl8zwDHIeejSQIMU4i2o4if4wIr1Z5QpPg7XJVwNE4i+mAvmHZbkpoxOr//kOiyihTwXiyTsSFc6OC/BVU2kc2buKrVNwD6gGKmYt8M8MVLQO9aNxOE1osp987VsNQ3e3Hdw8oovinQ0Km2A+w6KU8jeTvGlfnkjAhHVpigjpaiB5dkCueaoyka+QCk2xhRRNMVKWexG8LB0bJKOa9I+SiNQh2GGgymGjt0ckQxv8PVOLtr0doE1bkjnUNi2+GwZxhiUppbUW5ezhifWKmV0yI7a+P2MxdodI1+3T0w4L4CfanP386QsejMAxa4eLeet1SSB2x811kNRNphgFaZdcGVkp+0nfhILthMqH/Wp1swLae/4WANsLk48Pcq+DCmzH3qRecop/nI+yXDz4xC8o8yGZRimN5Ezat6IfA4x56LywvQJpYpuZWTciDBcIC7NRYvxW1DJd2MMli/QMeQGkgnzvABjV5k8hXTo7+a20oPJo82hmjUZ2cebaAzhKqAehiiNIZYrehKmmo22VBWS1pa1vtp0sz+WaD2GBrYuYdCrFyGSqM3DXVa0hpblCsCNd/+6V6xLQMZQEKLMtUCWCHXaUiFknwM4iKLAGAWLyLSwT0Jg8e1yNsKLwzBZECCo/4zHp6Dp84a4Erw7WXWuXDy9IFwNooZ5VVOLpxtAPlv0PBDgmY+8fXLXvtuevOLMcdiDxQYySHGZvf9fbyNBB8b3jXAVERA03eIk+Ach0w9S7HJVHTAwYJtTmZDUcSjSTv+k4BU5vr2VFKPHoXe/OhGqfLV7Z0/+1pJ9ecjRCrXSZjMM/Ky/68rO1TREuipeIors7paIZ7LihmedlPSthijNzlHzoiy1wcJPydhXsICrcia/EDYpeBgBONpb/7m63aE=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb266fe2-ea1f-40e7-695f-08db26d3ea44
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 10:39:41.3051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P3OAz05puMXqJLqYAwwb64rslRkwNcrYdxh4YgwqmVomdWRcDUL3DADU6srbKFRHXQoe15m/DA4YqqTKv3YjdaNA00iiKZkSZoJ2QvguGOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7545
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTQuMDMuMjMgMTc6NTksIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBIaSBhbGwsDQo+
IA0KPiBiYXNlZCBvbiBzb21lIG9mIG15IG93biBwcm9qZWN0cyBhbmQgSm9oYW5uZXMgcmFpZC1z
dHJpcGUtdHJlZSB3b3JrIGl0IGhhcw0KPiBiZWNvbWUgYSBiaXQgcGFpbmZ1bCB0byBkcml2ZSBt
dWNoIG9mIHRoZSB3cml0ZSBJL08gY29tcGxldGlvbiBmcm9tIHRoZQ0KPiBwb3RlbnRpYWwgaXJx
IGNvbnRleHQgLT5iaV9lbmRfaW8gaGFuZGxlci4gIFRoaXMgc2VyaWVzIGZvbGxvd3MgdGhlIHN0
ZXBzDQo+IHRoYXQgWEZTIGhhcyB0YWtlbiBhYm91dCAxMCB5ZWFycyBhZ28gYW5kIGRlZmVycyBh
bGwgdGhlIGVuZF9pbyBoYW5kbGluZw0KPiB0byBwcm9jZXNzIGNvbnRleHRzIHVzaW5nIGEgd29y
a3F1ZXVlLCB3aGljaCBhbHNvIGFsbG93cyB0byByZW1vdmUgYWxsDQo+IGlycSBsb2NraW5nIGlu
IGJ0cmZzIChzYWZlIG9uZSBzcG90IHRoYXQgaW50ZXJhY3RzIHdpdGggdGhlIHBhZ2VjYWNoZSku
DQo+IA0KPiBJJ3ZlIHJ1biB2YXJpb3VzIGRhdGEgYW5kIG1ldGFkYXRhIGJlbmNobWFya3MsIGFu
ZCB0aGUgb25seSBzaWduaWZpY2FudA0KPiBjaGFuZ2UgaXMgdGhhdCB0aGUgb3V0bGllcnMgdG8g
dGhlIGhpZ2ggYW5kIGxvdyBpbiByZXBlYXRlZCBydW5zIG9mDQo+IG1ldGFkYXRhIGhlYXZ5IHdv
cmtsb2FkcyBzZWVtIHRvIHJlZHVjZSB3aGlsZSB0aGUgYXZlcmFnZSByZW1haW5zIHRoZQ0KPiBz
YW1lLiAgSSdtIG9mIGNvdXJzZSBhbHNvIGludGVyZXN0ZWQgaW4gcnVucyBvZiBhZGRpdGlvbmFs
IHdvcmtsb2FkcyBvcg0KPiBzeXN0ZW1zIGFzIHRoaXMgaXMgYSBmYWlybHkgc2lnbmlmaWNhbnQg
Y2hhbmdlLg0KDQpBcGFydCBmcm9tIERhdmlkJ3MgY29tbWVudCAod2hpY2ggSSB0b3RhbGx5IG92
ZXJsb29rZWQgYXMgd2VsbCkgdGhpcyBsb29rcw0KZ29vZCB0byBtZS4NCg0KQnV0IEkgaGF2ZSBh
IGdlbmVyYWwgcXVlc3Rpb24sIHdoaWNoIGV2ZW4gbWlnaHQgc291bmQgcHJldHR5IGR1bWIuIEFz
IHdlJ3JlDQpvdXQgb2YgSVJRL2F0b21pYyBjb250ZXh0cyBub3csIGRvIHdlIGV2ZW4gbmVlZCBz
cGlubG9ja3Mgb3Igd291bGQgYSBtdXRleA0Kc3VmZmljZSBhcyB3ZWxsPw0KDQpCeXRlLA0KCUpv
aGFubmVzDQo=
