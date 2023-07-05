Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B197747FF3
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jul 2023 10:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjGEInJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 04:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjGEIm4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 04:42:56 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1DF171D
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 01:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688546564; x=1720082564;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XR6UfEwGdHe9PnXWwGrV5Egzw73Xd53wz2Nd6fg6bjI=;
  b=hBGCDSQS6FHQKJPybP8vH98VvkUiH/bxnV4dtzcInh5YHIvjprc7bhZl
   NUwTQFMfd4DO5Wp2U3w+EMmtCPgXCChi+bCuWJpTKSs3jnxH1MC2zDqDu
   IG5sUM753t51cfK69eRFWgJNl44INzXek8XZn9kXx65Z/x6aj7G18CEc6
   4CeEr/LiphbHPZpE/YrKmPQoGU21qz3xcjRFIA0niFxXBkX9sP1Gpozh6
   W67SdowOGYMn4mjOEM3p8WVL++UHoub45DezJInFE0sgEDkJnPAMu+r45
   wXxym5oFwV18QAP5J7ielrR3PhKYRrRBPm8rvl8yZrUNZtwtnU/HZwXox
   w==;
X-IronPort-AV: E=Sophos;i="6.01,182,1684771200"; 
   d="scan'208";a="342311791"
Received: from mail-mw2nam04lp2175.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.175])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2023 16:42:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2yQu9+PxWWoA21udIQnGsRX20xmXR234YfsowRVlTf0poGtQ56Z7qM1rW5jmWCAWkOT3fZaY2jl575WFtS3F0Tzp4Qwg6kseaT1LSoZRA1+SJydH573OIZcqI5y67s2bDygRQ1+3InCHaAS9HwO466TbdPwhAQmKGm/S0GJk96i5z7jjGjTE+CB6w0BsD5VdUcyZmFXu8vZLPEv05nlgosdM8QIFdWjpDK8P4sbjPXh5PE1eSIcpkZ9RWXyll+9VHnkU4Km68kH/uRfq58mRVeeFT90ROxz1aVKwBQaenFMB6DjBmystClrlSIZixzVdz8nlQEuwHdLPmx8xEKUTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XR6UfEwGdHe9PnXWwGrV5Egzw73Xd53wz2Nd6fg6bjI=;
 b=KT37F00zc6A7Uq4bn7/eMR5m7YMeHh9LtNnliOI2MTuFBxJrXZG691ECxY96QOJg8Xk9JEVdBw8b+ehVtPb02CKPghu1boBbCRu7WMHMVOzH4BG2/wMXbvByIq8Bs3PPkKC8BELeHIR556POL4z3UM6SiaEq7OpAJsoO/Ki5Yo6aIKxImGT6RTTUbn1XWQaF1aNDZVaLkWfgsUofJQBkBpGXmmeopyJnRcZ0yJQ6SgRnG2x64b+jTzuLPps62U7F0fZEamNjgHzXGV5bsaXtZD0V4Sldx42ZsjVFdZGo2yH9mQz4SAAgO8WOeO59VneveRYIVg7wLZib6YJtJz6xcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XR6UfEwGdHe9PnXWwGrV5Egzw73Xd53wz2Nd6fg6bjI=;
 b=zOD2YyfuavNTHZZWzt+5zl5ZnmpxNyZCmTuijICvztu1QyFmkzCk2U4h6wlCt6vAaH0EIYyQGvhTYt0vWFu1WybW5txHd+n7za+H35lXEeHA0uzvLWYEHiL9fZUFEje+qUZknNDerut8y+iZ2cTqld+eJItLXkt3yEUD6xoGiFA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7557.namprd04.prod.outlook.com (2603:10b6:510:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 08:42:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::fc3f:4892:d2f7:bbbb]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::fc3f:4892:d2f7:bbbb%6]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 08:42:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs: zoned: don't read beyond write pointer for scrub
Thread-Topic: [PATCH] btrfs: zoned: don't read beyond write pointer for scrub
Thread-Index: AQHZraRBpvICTBNaLkeIplXc4oA8cK+n8YCAgAA+uoCAAHOJAIACOkOA
Date:   Wed, 5 Jul 2023 08:42:40 +0000
Message-ID: <76b099ac-ea2d-2237-fd06-72418c1f2492@wdc.com>
References: <51dc3cd7d8e7d77fb95277f35030165d8e12c8bd.1688384570.git.johannes.thumshirn@wdc.com>
 <1449f988-b5f6-3a21-eea0-44298ed7dd42@gmx.com>
 <96a5d8e6-8905-231a-b55a-876919c60694@wdc.com>
 <1513dfe3-8d58-a511-5279-c6bf1ecd0e0e@gmx.com>
In-Reply-To: <1513dfe3-8d58-a511-5279-c6bf1ecd0e0e@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7557:EE_
x-ms-office365-filtering-correlation-id: 39816548-ba37-40cb-4df6-08db7d33cabb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kq/OTVXW1McO4gg9NsOmA471FIlgCuFcbOOfPjeYCQcNoJ7t5EibgtXSpkaEKniCj7zLzhlCUozzguPGmQpVaROZJySeHUvmF7ScnAzfVRY6YQ7/RnsWUUJHCVSEeAGqFCHH23N69NBfJysq4uXI1hoW4k62GIcJ6vacNXP0ytNV7LqIltGsKwm627EtmtepNRMrYfWs+qUwhON7xU6LTVVfwtTR/GEPKMFrJK7E2iN5Z2GG80D3lyp3c20iCcPna8Nj/jN6CfmVtm+8xqaTYTyanCwdtir9R6mxjmHzkSigvLgaCeCdAebp29ac9idTuwC2atB+LwOMih7Xr/nuWeDNJfr64p9KkfeypUU6E6sA2O7x9KO58IKugYXIJvremddqyibS5hINsSBXDwQCNukbS632sFbFdjrt61xXh/Iolnc8SNiqKTEoWa7VbpAkwaMT2KSGZ1OepvTkgXHs4EPc5hQRo25iMc55f2ZwCwxH7wS82GP5lLYiu6tKiFGoUg1HWvRmq3Vs3DoF+wq/GddhsBmXAjraLROr3lVH3rhMR6i21QgNSrnfLk8MhcRIzw7StQx59lEAi90TAi+Xy4IdADc6dK3whBU+Gfe3QYeORZabZylllcnQS7lZA/yWkoN5+ectPXWMKU6K6lgEVUy/RnMeYSNOC1SUf4Qo4TE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199021)(186003)(2616005)(76116006)(91956017)(2906002)(5660300002)(6506007)(53546011)(26005)(8936002)(8676002)(31686004)(41300700001)(64756008)(122000001)(71200400001)(6486002)(82960400001)(36756003)(83380400001)(66476007)(4326008)(66946007)(66556008)(316002)(66446008)(110136005)(478600001)(38070700005)(6512007)(38100700002)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUs3NjZlQ3BKYjBEZGduTFNVMFRIeGpTczBRV082RVRXclJ4WkRGM2FrSFF0?=
 =?utf-8?B?ZHAzUDVFSXNpcHVPVkhzRWhkTTRrN1hVeGNsRU9BZFZKWWFNcTVtWHNOTlpZ?=
 =?utf-8?B?LzlqK3dVeG9YMnk1MzVhWDJWZzg2eW1GT1dhRXoyZEIvT0llR3FuTGxFOWM4?=
 =?utf-8?B?cnFpMFV4dCtpUGlpK3dZcWxPRlVkcTQ0TzhmWk5BMC9yMVIwU2FsbndScCti?=
 =?utf-8?B?V1lSc0lpTG5qRWRaMmdhMUJvRk9iY1FTREx2a0ZCRkNiRzl5Sk9FM3gzeVhD?=
 =?utf-8?B?ZVJWa3RNYXhoT0lBSUlaU2xRZC9oY212S0RLejdCL2F3ZVU1eDdhM3JSSnVi?=
 =?utf-8?B?OXQyNHVTK2Rob0lrWFQzVm9mc3hTbE4xYWtkWHZsc0tHaDJEVCtVVk0ybk8v?=
 =?utf-8?B?S2N6NzBkcFlmMEh5YnpZcld5SHFQbUtoaXNRaC9ndTljMVc2dVhuZ3hSTHk5?=
 =?utf-8?B?Nnhjc3pvaHJlcnhkMjhMT1FFOGd0cCtvZzVVdEVRZmloRkxBRnFDWEUzT3pz?=
 =?utf-8?B?bkU2TU1lQUlTNndLNkFpZi9GT1R0OXJ2UUlaSkc5VUtZbHFPUXpEZXd1V3Nj?=
 =?utf-8?B?T0FsQmk0U0U0K25GakI4UVNVM0ZIaC9uYWxLUWZEbXAvQ2RzYURObmtNdnJY?=
 =?utf-8?B?djFDUXduNURxeDB3cm9ZWVlGZU4zRU1uNWpUWExEM0FKSm91b0F1TDgvNTJq?=
 =?utf-8?B?SXlETVVxa2YrQU9TVGJtaXFWZ0x0by9uSk9Pb1hHd2ZHL0dLR2VycUtWOElv?=
 =?utf-8?B?cXAwRVlXMUJENlZ5NWRJVHVpUENYZW1tRTdGWFNpV09Sc1JxdjVPK1k4VzFS?=
 =?utf-8?B?bjdOWUpQTW1DQkhyc3dVeW1QSTNWNUg5Q1J5eXcrQ3hCbXVnWS9JSjB6YjVZ?=
 =?utf-8?B?Wlh0TEEvWWFHWDhMa2EzdDl4VExjbklaaHhoUkY1ZnoyekNrMzN3QXA4c1VL?=
 =?utf-8?B?My8rSEFuN2JibFNWQ08rSlpRaGJXc2M4VEpmL1VzRGhtUmFFTmkwSWU5Z25i?=
 =?utf-8?B?Z3NoRW1WUDhSS0RPSjZHOUFkV1lqYjhIRCtnRS9pOEZJUE00Vml1V0tKT0Jr?=
 =?utf-8?B?YUxocHhMZkp5anBXVjIrcFM5NzRVWHVjRDBlYkN1NEZlWkNSME0vU3pmWXpJ?=
 =?utf-8?B?Q1ZJTHJsVmhzMUxvRzhJMy9rZWF3WGJFM3djZGJGeHU3L2JYbVV0MXZ2RFZC?=
 =?utf-8?B?RTIwREdVdGRMbFdEVUdLOWd6Z3dtZVlKMWpkV2dqY3JFaU5LQVd0ZEYxbVlJ?=
 =?utf-8?B?eEJSZjhRaFhDRE4zUlI4RGJqU0t0eVMwNkgzODkyOW5ldExEV0FnOG1XZnZT?=
 =?utf-8?B?SlBjR3QrVnNlY2x2TlczWWVQZGExTUtnZmcranpIT3hnTkYwdzBrQzA5cVRt?=
 =?utf-8?B?MW1JMGt5Y1VvR09ZMVo4RUpoWlhobXpydnVBcWMrNDBQTC9neEpEQ2M5YVla?=
 =?utf-8?B?ZC9kYzNZYUMzT2luMUVONXQxMzlCc0RQNFdOQlZlMEppZDNscXZtU2Z1RjJH?=
 =?utf-8?B?SWE1UEhMSjdwN2I4WlQyK0cwVXNDZ3V5eHZXY1Vybjl0Zm5HODBDYXJWb1hN?=
 =?utf-8?B?Sk1BWWRxN1hBTnZ4eXVQNVhyNkk2N0lCbVA5d2dDdGorbGpReVFDczFZdm40?=
 =?utf-8?B?aUtLUW1oTFk4Z3ZOUUxVRjdyNWd5ZHpkSFdJMGVncmpvdGt6N2UrK3NuNEtm?=
 =?utf-8?B?QzNyTmpncldpTjlwdnhpTlc4cUhtbThJQkxudkp4bU1MZVZSQmM4TnYwMExl?=
 =?utf-8?B?QlRJd1p0OWtweTRaWEtXUFVwZ3J3V3pTVVdDNFN4QlBBb2VIY2Qxamcxa3Fy?=
 =?utf-8?B?UHA0dXNuUFp2L3JBNEpaWVFlaFJyS2s1dzM0b21RL2ZzZHdXRm4yU2h4ZjJq?=
 =?utf-8?B?TG9wV2JueTdYQXI5YTYvalY4WjhiY0tpRFNKUmhWMXUwSVB3bGkwbXRKS0dv?=
 =?utf-8?B?YnF2NGVCRjlkRHV0MHRHSkMvSnBIVzBtVWU0LzFTSlZDU1AwQTNNZmdhVnNZ?=
 =?utf-8?B?WjVheUVsT3FJdlRRbVZXY29BZkt0OUhNZUhuL0IvZndEWHRPQjVxVXF2TThm?=
 =?utf-8?B?NGEwaklhT0l2NGRvN0pralYxRGVneWdoT3IyM2k5Wkozbm5udDZWNFhndTZ6?=
 =?utf-8?B?QkFZbzYydUo1a3JmWEdvK0dYQU1ESHBISUR0VWhxR1FudkFVM3VkZi8vZGRz?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B63280E7EEE13749910B7D9209867F0A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kwfaXriYJjVD+rAxTuoLFEThI2Z9KUgyoTX6yo67Ksl7+n+h/nKdeXRvEbXhEiHymRxUqY+h7LESDgKZeqYfwas6JIsL4/l/M9xxPk71Hu91sESdKuYuYrcsp+JlkpUd4hCt6gtR84EJeGiAFOSQLBE0NSPLwXIBfvCRhzMQgu3KCV2wdK6KRBE86S4vmNTc2H8YbY4sbgKTg56BPVuwCJXj147xkIk4xLj/vfLnX2JGEB+OHc41VUODtMZSQfzNNCFI+I9kiSURKB8cbkg2DFVeLR6t5/OIDbz/yqzTVnWVARqjn6GrXSzeorXOg60XTCRgttYIdPdv38+Bk22rHudJoZAUSYRHlSaAd7O+00Vdn8iDkXG+mA3gFiHKHecG3RICEvPbZq5RhpvXmsfGUXon81ZKoDgqUSrTj/LsPgywtxF//+o8ZgjXF/X/fgi5osDVDlEu4mMQEtaVyyK/OthTEOyndPquj8yw0Lf/xR8JF6GFK4LQH+rEKMvPpxos1EkOr0rwxkb7Td9XriOJ+JHuGLowDQSX97iS4IV1OorL5xJ30BbLL2iX1hkYKayx40li6hN0wgoNWsmOMjsuMz8WjvYUlTjQRPV4jM09z38XlJyjA/6kxM3r5VXkk96iqYU6qkTpkCMq5YK6LdB4QDZhU6G1sBBTuyl2WzKsvDVB6ygojGoIRS9coVIa1hG6D3D43jam06D6HpQ2Ee7VOHr8HLSt6jv7flEmaEE6dh1oe2BeY4Auuar9dl2DjGgvbJRgLNM7CYsf3rTX4z8wvoVRIm5tiCmNkl+A+r4/oRdYan5yB8AfeXK2uY8WSqeA
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39816548-ba37-40cb-4df6-08db7d33cabb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 08:42:40.0752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RMi04717w6+L3e1WYhyto/0JmIPBEZjl8pLPXNw6JvNrst7Hyo2ikXusnT5VHxeb3B+7uVW7iD/pwhYf6mp7F6BsbIQFr3Hb88a49+++rG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7557
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDQuMDcuMjMgMDA6NDEsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiBPbiAyMDIzLzcv
MyAyMzo0OCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4gT24gMDMuMDcuMjMgMTQ6MDMs
IFF1IFdlbnJ1byB3cm90ZToNCj4+Pg0KPj4+DQo+Pj4gT24gMjAyMy83LzMgMTk6NDcsIEpvaGFu
bmVzIFRodW1zaGlybiB3cm90ZToNCj4+Pj4gQXMgYW4gb3B0aW1pemF0aW9uIHNjcnViX3NpbXBs
ZV9taXJyb3IoKSBwZXJmb3JtcyByZWFkcyBpbiA2NGsgY2h1bmtzLCBpZg0KPj4+PiBhdCBsZWFz
dCBvbmUgYmxvY2sgb2YgdGhpcyBjaHVuayBpcyBoYXMgYW4gZXh0ZW50IGFsbG9jYXRlZCB0byBp
dC4NCj4+Pj4NCj4+Pj4gRm9yIHpvbmVkIGRldmljZXMsIHRoaXMgY2FuIGxlYWQgdG8gYSByZWFk
IGJleW9uZCB0aGUgem9uZSdzIHdyaXRlDQo+Pj4+IHBvaW50ZXIuIEJ1dCBhcyB0aGVyZSBjYW4n
dCBiZSBhbnkgZGF0YSBiZXlvbmQgdGhlIHdyaXRlIHBvaW50ZXIsIHRoZXJlJ3MNCj4+Pj4gbm8g
cG9pbnQgaW4gcmVhZGluZyBmcm9tIGl0Lg0KPj4+Pg0KPj4+PiBDYzogUXUgV2VucnVvIDx3cXVA
c3VzZS5jb20+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5u
ZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+Pj4+DQo+Pj4+IC0tLQ0KPj4+PiBXaGlsZSB0aGlzIGlz
IG9ubHkgYSBtYXJnaW5hbCBvcHRpbWl6YXRpb24gZm9yIHRoZSBjdXJyZW50IGNvZGUsIGl0IHdp
bGwNCj4+Pj4gYmVjb21lIG5lY2Vzc2FyeSBmb3IgUkFJRCBvbiB6b25lZCBkcml2ZXMgdXNpbmcg
dGhlIFJBSUQgc3RyaXAgdHJlZS4NCj4+Pj4gLS0tDQo+Pj4NCj4+PiBQZXJzb25hbGx5IHNwZWFr
aW5nLCBJJ2QgcHJlZmVyIFJTVCBjb2RlIHRvIGNoYW5nZQ0KPj4+IHNjcnViX3N1Ym1pdF9pbml0
aWFsX3JlYWQoKSB0byBvbmx5IHN1Ym1pdCB0aGUgcmVhZCB3aXRoIHNldCBiaXRzIG9mDQo+Pj4g
ZXh0ZW50X3NlY3Rvcl9iaXRtYXAuDQo+Pj4gKENoYW5nZSBpdCB0byBzb21ldGhpbmcgbGlrZSBz
Y3J1Yl9zdHJpcGVfc3VibWl0X3JlcGFpcl9yZWFkKCkpLg0KPj4NCj4+IEknbGwgbG9vayBpbnRv
IGl0Lg0KPiANCj4gSSBjYW4gY3JhZnQgYW4gUkZDIGZvciB0aGUgdXNlIGNhc2Ugc29vbi4NCg0K
RGlkIHlvdSBlbnZpc2lvbiBzdGguIGxpa2UgdGhpcyAodW50ZXN0ZWQgYW5kIG5lZWRzIGNsZWFu
dXAgb2YgQVNTRVJUIGFuZCANCmJ0cmZzX2NodW5rX21hcCgpIGNhbGwgYnV0IEkgdGhpbmsgeW91
IGdldCB0aGUgcG9pbnQpOg0KDQpkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvc2NydWIuYyBiL2ZzL2J0
cmZzL3NjcnViLmMNCmluZGV4IDM4YzEwM2YxM2ZkNS4uZjAzMDFkYTk4ZmI2IDEwMDY0NA0KLS0t
IGEvZnMvYnRyZnMvc2NydWIuYw0KKysrIGIvZnMvYnRyZnMvc2NydWIuYw0KQEAgLTI0LDYgKzI0
LDcgQEANCiAjaW5jbHVkZSAiYWNjZXNzb3JzLmgiDQogI2luY2x1ZGUgImZpbGUtaXRlbS5oIg0K
ICNpbmNsdWRlICJzY3J1Yi5oIg0KKyNpbmNsdWRlICJyYWlkLXN0cmlwZS10cmVlLmgiDQogDQog
LyoNCiAgKiBUaGlzIGlzIG9ubHkgdGhlIGZpcnN0IHN0ZXAgdG93YXJkcyBhIGZ1bGwtZmVhdHVy
ZXMgc2NydWIuIEl0IHJlYWRzIGFsbA0KQEAgLTE1OTMsNiArMTU5NCw0NyBAQCBzdGF0aWMgdm9p
ZCBzY3J1Yl9yZXNldF9zdHJpcGUoc3RydWN0IHNjcnViX3N0cmlwZSAqc3RyaXBlKQ0KICAgICAg
ICB9DQogfQ0KIA0KK3N0YXRpYyB2b2lkIHNjcnViX3N1Ym1pdF9leHRlbnRfc2VjdG9yX3JlYWQo
c3RydWN0IHNjcnViX2N0eCAqc2N0eCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc3RydWN0IHNjcnViX3N0cmlwZSAqc3RyaXBlKQ0KK3sNCisgICAgICAgc3Ry
dWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8gPSBzdHJpcGUtPmJnLT5mc19pbmZvOw0KKyAgICAg
ICBzdHJ1Y3QgYnRyZnNfYmlvICpiYmlvID0gTlVMTDsNCisgICAgICAgaW50IG1pcnJvciA9IHN0
cmlwZS0+bWlycm9yX251bTsNCisgICAgICAgaW50IGk7DQorDQorICAgICAgIGZvcl9lYWNoX3Nl
dF9iaXQoaSwgJnN0cmlwZS0+ZXh0ZW50X3NlY3Rvcl9iaXRtYXAsIHN0cmlwZS0+bnJfc2VjdG9y
cykgew0KKyAgICAgICAgICAgICAgIHN0cnVjdCBwYWdlICpwYWdlOw0KKyAgICAgICAgICAgICAg
IGludCBwZ29mZjsNCisNCisgICAgICAgICAgICAgICBwYWdlID0gc2NydWJfc3RyaXBlX2dldF9w
YWdlKHN0cmlwZSwgaSk7DQorICAgICAgICAgICAgICAgcGdvZmYgPSBzY3J1Yl9zdHJpcGVfZ2V0
X3BhZ2Vfb2Zmc2V0KHN0cmlwZSwgaSk7DQorDQorICAgICAgICAgICAgICAgLyogVGhlIGN1cnJl
bnQgc2VjdG9yIGNhbm5vdCBiZSBtZXJnZWQsIHN1Ym1pdCB0aGUgYmlvLiAqLw0KKyAgICAgICAg
ICAgICAgIGlmIChiYmlvICYmDQorICAgICAgICAgICAgICAgICAgICgoaSA+IDAgJiYgIXRlc3Rf
Yml0KGkgLSAxLCAmc3RyaXBlLT5leHRlbnRfc2VjdG9yX2JpdG1hcCkpIHx8DQorICAgICAgICAg
ICAgICAgICAgICBiYmlvLT5iaW8uYmlfaXRlci5iaV9zaXplID49IEJUUkZTX1NUUklQRV9MRU4p
KSB7DQorICAgICAgICAgICAgICAgICAgICAgICBBU1NFUlQoYmJpby0+YmlvLmJpX2l0ZXIuYmlf
c2l6ZSk7DQorICAgICAgICAgICAgICAgICAgICAgICBhdG9taWNfaW5jKCZzdHJpcGUtPnBlbmRp
bmdfaW8pOw0KKyAgICAgICAgICAgICAgICAgICAgICAgYnRyZnNfc3VibWl0X2JpbyhiYmlvLCBt
aXJyb3IpOw0KKyAgICAgICAgICAgICAgICAgICAgICAgYmJpbyA9IE5VTEw7DQorICAgICAgICAg
ICAgICAgfQ0KKw0KKyAgICAgICAgICAgICAgIGlmICghYmJpbykgew0KKyAgICAgICAgICAgICAg
ICAgICAgICAgYmJpbyA9IGJ0cmZzX2Jpb19hbGxvYyhzdHJpcGUtPm5yX3NlY3RvcnMsIFJFUV9P
UF9SRUFELA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmc19pbmZvLCBzY3J1Yl9y
ZWFkX2VuZGlvLCBzdHJpcGUpOw0KKyAgICAgICAgICAgICAgICAgICAgICAgYmJpby0+YmlvLmJp
X2l0ZXIuYmlfc2VjdG9yID0gKHN0cmlwZS0+bG9naWNhbCArDQorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIChpIDw8IGZzX2luZm8tPnNlY3RvcnNpemVfYml0cykpID4+IFNFQ1RPUl9T
SElGVDsNCisgICAgICAgICAgICAgICB9DQorDQorICAgICAgICAgICAgICAgX19iaW9fYWRkX3Bh
Z2UoJmJiaW8tPmJpbywgcGFnZSwgZnNfaW5mby0+c2VjdG9yc2l6ZSwgcGdvZmYpOw0KKyAgICAg
ICB9DQorICAgICAgIGlmIChiYmlvKSB7DQorICAgICAgICAgICAgICAgQVNTRVJUKGJiaW8tPmJp
by5iaV9pdGVyLmJpX3NpemUpOw0KKyAgICAgICAgICAgICAgIGF0b21pY19pbmMoJnN0cmlwZS0+
cGVuZGluZ19pbyk7DQorICAgICAgICAgICAgICAgYnRyZnNfc3VibWl0X2JpbyhiYmlvLCBtaXJy
b3IpOw0KKyAgICAgICB9DQorfQ0KKw0KIHN0YXRpYyB2b2lkIHNjcnViX3N1Ym1pdF9pbml0aWFs
X3JlYWQoc3RydWN0IHNjcnViX2N0eCAqc2N0eCwNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc3RydWN0IHNjcnViX3N0cmlwZSAqc3RyaXBlKQ0KIHsNCkBAIC0xNjA0LDYg
KzE2NDYsMjEgQEAgc3RhdGljIHZvaWQgc2NydWJfc3VibWl0X2luaXRpYWxfcmVhZChzdHJ1Y3Qg
c2NydWJfY3R4ICpzY3R4LA0KICAgICAgICBBU1NFUlQoc3RyaXBlLT5taXJyb3JfbnVtID4gMCk7
DQogICAgICAgIEFTU0VSVCh0ZXN0X2JpdChTQ1JVQl9TVFJJUEVfRkxBR19JTklUSUFMSVpFRCwg
JnN0cmlwZS0+c3RhdGUpKTsNCiANCisgICAgICAgLyogRklYTUU6IGNhY2hlIG1hcC0+dHlwZSBp
biBzdHJpcGUgKi8NCisgICAgICAgaWYgKGZzX2luZm8tPnN0cmlwZV9yb290KSB7DQorICAgICAg
ICAgICAgICAgc3RydWN0IGV4dGVudF9tYXAgKmVtOw0KKyAgICAgICAgICAgICAgIHU2NCBtYXBf
dHlwZTsNCisNCisgICAgICAgICAgICAgICBlbSA9IGJ0cmZzX2dldF9jaHVua19tYXAoZnNfaW5m
bywgc3RyaXBlLT5sb2dpY2FsLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBCVFJGU19TVFJJUEVfTEVOKTsNCisgICAgICAgICAgICAgICBBU1NFUlQoZW0pOw0KKyAg
ICAgICAgICAgICAgIG1hcF90eXBlID0gZW0tPm1hcF9sb29rdXAtPnR5cGU7DQorICAgICAgICAg
ICAgICAgZnJlZV9leHRlbnRfbWFwKGVtKTsNCisNCisgICAgICAgICAgICAgICBpZiAoYnRyZnNf
bmVlZF9zdHJpcGVfdHJlZV91cGRhdGUoZnNfaW5mbywgbWFwX3R5cGUpKQ0KKyAgICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIHNjcnViX3N1Ym1pdF9leHRlbnRfc2VjdG9yX3JlYWQoc2N0eCwg
c3RyaXBlKTsNCisgICAgICAgfQ0KKw0KICAgICAgICBiYmlvID0gYnRyZnNfYmlvX2FsbG9jKFND
UlVCX1NUUklQRV9QQUdFUywgUkVRX09QX1JFQUQsIGZzX2luZm8sDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgc2NydWJfcmVhZF9lbmRpbywgc3RyaXBlKTsNCg0K
