Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B5E6F5228
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 09:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjECHqr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 03:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECHqq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 03:46:46 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28481997
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 00:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683100005; x=1714636005;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=psF+YwwjKz8viwdtkNWijeImXNO1Z5B4wimQb/BAYA6e54k4d3/N4fSw
   S4IO7ERmEwVNIQUu3tEFd+j9Aq4EhQ6tvjU27gwIfW+P3rfmsnWy38OTt
   9P7h1XVD1weBcMaN8abVh/8d5PPBmH8by0zSikMur/g2rUCRavTYP5g5p
   nwgjjvSO7J/DBSYP1PA9r6gkZQPuVG3tAJip62IzkBK1aA02vR8r38K3c
   pWV2NmC05ebBLJ/PPcMXII3/UnMYSLZNUa7IIhA38b0uiOz2x7p+v2+s8
   5i4LqheVhU+vPil8aKb04Z4oLct2yhLcGthdrOvX8hTpvn3BcsjMqRqxT
   w==;
X-IronPort-AV: E=Sophos;i="5.99,246,1677513600"; 
   d="scan'208";a="229671656"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 03 May 2023 15:46:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLLLfjg3KfwTl7E1jzuHbpYBEui59ljjLO7PxKuSJ1YeLUckSqlcEe0DmzQHYhvQfxmIQcjWI+dVgtZe0aRdtQmykaFXYlBwJTKa+txSWxVlc6csWNj5rui6XBtP4rNdQzc6gVPlMe6rN2INaMc5bjt5SUm5Ngow1hl8DYkLVJ7mPA8kXCJnzj9aukcAiGMJ+r/vGSSqpupLnXqkazpz7lAcuukluR3KeOI6Ie9iAKpST5zon1QQyyGkriv2M5aQwySRFGjhPXXk50j9EqgY/ZLkYHt2szP2eKSqTATmkE7qs8/JFpdo2mnnnuKTRb9M4xWviKeeDNRnE5ZhVR5ytw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=LnzQan1LfgdKDWtb4eX2jsR31Xo4wC/NvFO/IDZbrWpjP01Tg4Nk9QodccFj9AQX62PHN3SKO6DrzLnOqC27Uiv1WIToJsQMm5A71sSN9HgJHCwnd0sJwS96ev+DtDlB/WLb0sqxVptuia0pxz7UyLwA3Ft2eZ047u2dx0kA3u7JBtuCFPUybatiR5hGRKTTwR7EoauhFwJv2GcXIySMC2TLF2h4nI6JYNLYyyX5enRJgS5zONlQC+3XjA+r0JK4TXFr/wun4lEOTloofWRNKaDqxBpOkDgdMxNNX1sIAPik6NFhom/qep+JYurFs1/IHzMdgqSHDVkawZ5EPfRdKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=pMABVOVoa1B7Jk0akNX2w2lxmLLrcBdx0f0ObGIE92WCvTE0MJJDmNIERpxW+XB7alQyT7hg4JaaoNcuaboe0BCBajz7iITZ48EhcTfw3nlG9Vt61kY5TSEbFZ6pCZ++pskIgCiEpwzb1naQAsxC/cttvgOPBGuQ5yyHM2zQjKA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB8163.namprd04.prod.outlook.com (2603:10b6:610:fc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 07:46:43 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 07:46:43 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/3] btrfs: don't reinvent synchronous writer detection
 logic
Thread-Topic: [PATCH 2/3] btrfs: don't reinvent synchronous writer detection
 logic
Thread-Index: AQHZfY3NCTs2OjrFjkOHA3K4YcCsXq9IK7KA
Date:   Wed, 3 May 2023 07:46:43 +0000
Message-ID: <87f2b3ba-94c4-b6b2-dcab-8b0d3d19dd21@wdc.com>
References: <20230503070615.1029820-1-hch@lst.de>
 <20230503070615.1029820-3-hch@lst.de>
In-Reply-To: <20230503070615.1029820-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB8163:EE_
x-ms-office365-filtering-correlation-id: 1ab756d4-5441-484d-19a0-08db4baa8a0e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /h4GUpF0qnLtEUxJm+5Je3ofLFIP4gseX1n+Df3DYFwy2WXw4TScu9MD4Rp5y1FAA48BqEFhAMpN4XKnf0NYuYGKQkmvjYXFBx6MGaSSfovDINrqedicR3m1bpObD2I/BKQ0f4gEnFFQot96RbJgpMM66s0zB6C9cM90OUvShPt+T/DD6MRlga2GiV9f80wdSJNfpX9tyZo6v5lbAhwZSLO7sFNqGqq1hpR6bG09y+8kj846wVMj7eip65XzQ2k1XjS59sCVfYI8wCwyMaHsdpxq/INoJ/BeKLMwH338DIw2Au85NiMcyf4v7gLOx5NXz52Nk8uEqhiN3j4HdxVNCvopYDJHu8A+LbE2FoojDagoenSjFOShhjCWnbtyxVoATiR6P/iyihM/nXqV2FAIMXQVjTrCvWgdMCSzMFrgFoCXLFjHGkBnwEhMwFbl+5DvrJ5HVYgm4xyqaEZ165o/nFcPNsHY3aDtDEHRI/yXqLpm5N06ZsFs5Nk0KBMfuOEsufsIfdkiLmjiG7EAFC9WEJYbRXLLJrOozkgu/XpIJGI3Tsw6Rx7Yb/bRaBfEkNMzkxc9vhVzRc9jF0GrEsJaXcBRaFHTcTKtCJPcat635gVEPsvNDi2n2pNsL1DobGk8GigoasREi1DNfkWB0PwCuUCuaXneQkT5OkywGJ6/NJnInSPKLvqUVunoRlaisUWe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199021)(2616005)(26005)(6512007)(6506007)(41300700001)(38100700002)(122000001)(31686004)(71200400001)(6486002)(186003)(4270600006)(76116006)(478600001)(110136005)(66556008)(91956017)(66446008)(316002)(64756008)(4326008)(82960400001)(66476007)(5660300002)(19618925003)(558084003)(2906002)(8676002)(36756003)(66946007)(31696002)(38070700005)(86362001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dytBbGE2R0pndWFxOUJKZFgrVWJQUlQrSlByZk5EcHQyaklRWkdzWTR5VGZw?=
 =?utf-8?B?dW9aMVNUZ24reWx3WXBVL2MweU1aZ0tIbU9mQnNpcmkzVnNOMWhpMDBLM21v?=
 =?utf-8?B?amZ1WjA5dDRUbW9lQmpYOEtTVUlQa1d0YTRERXU0cklBNHdDYkpQWXZJOHI5?=
 =?utf-8?B?YS9zUnBWSE1pVjB4Yk9HTHNDNHEvRDI0QkNETnZMeFk5UlpUK2M1V29ITTZO?=
 =?utf-8?B?Z3JIalhCUHZEcTBQZU5VdEZKQ2tueGxVNHZnd0ZCZmpSYlg2c3R6a2lmSjdh?=
 =?utf-8?B?RmFzYzAxLzR5clFTL2pWL0owQVg3RlpCQkpQd2l6czdjODlpRDZEWHlwRVZH?=
 =?utf-8?B?L3dleUFGY0w5Z3JMbWUvVjFSb0puSDJNek9nMGVUemdEZW1pQ0hNOXhlb0JS?=
 =?utf-8?B?Wjg0NUttbFZCbjZNQVdta2c4Z0FzcXZkaHVTV2p6VFd1UE45TThiMTdoSUc1?=
 =?utf-8?B?UlUyaUJGVEtUS1pMOFQzK08rVGUrKyt0ZmNmOEFSUnhBQkI1a1lNV0grMUdw?=
 =?utf-8?B?VWdlTkUzNkFlcXVpQmRNZWkyOGowcjJJdGV3azFCVHV2ZUg0U3I4cnRRVHhL?=
 =?utf-8?B?bHVlNVVKUmVMcE16cWxtTTBkYjg5SHNUTTNhM004SmhXTFhkUzV4MVNmMXJl?=
 =?utf-8?B?VDUybGZzazVIbzFnOEJMSWFGbEdMZWhDQno4dkF4L01oTFpIbVdyZFl2a0ww?=
 =?utf-8?B?eGNBcTY5VXBGTUNEVy9XQjFrdFptRW53V0Q5bGJIbi9rNFNRS20yYVZkUFR6?=
 =?utf-8?B?cW5jMXppZkRqRzNHS0dnNE80MVFyQjYzZlNCRlFzcnhNclBzNVJTN1NhNmor?=
 =?utf-8?B?L3ZNcTRTc1MxemZuNWVINDE4MDR5SHhKZHMyT0NMemVsT2tIcGZZejIrUXB6?=
 =?utf-8?B?ZURlRDBSVjJPTmhXV21oWmFnNzhpeGdjV0pYOXdBSjFFOXJTR0ZyYzZTREdL?=
 =?utf-8?B?UFZwUStJQS8ydWdyc1JsenZ0R3M0dkE0K2hHUXNrcTFPRm9VV291c1dBWGxu?=
 =?utf-8?B?bGVwaFVyRUhnejNsTGczNXcva0hMcXlxNDFwdlpsWURKcm0xb2NodmN1NFN3?=
 =?utf-8?B?YzRzcUs5SWwzU21ReW50UFFVSElscXlxKyt4WnBCeUw2dUgvSHg0dU81SDZM?=
 =?utf-8?B?VVdraWdPNHltYWozUVVHRXYzeVJXSDB2Y2YxVDJUWUZGSG51cklETEsrNU03?=
 =?utf-8?B?Qi9NSHJFYzFRL0Y1UkZTTEtUSnI4TjAxZG1WZWFtVkZlZjFDdUJxWVJYS3k5?=
 =?utf-8?B?eHEvOXlqZEhRaityY3JBYlBFa1NoMTNuMUJKdXdlSjUyMTNIUlBUaW1RTXhx?=
 =?utf-8?B?bnRrM0NHaitkWmNDRkdDRHpZS1FrckpHRlFJQzhWdU5veVBOb2I2N05tVEtC?=
 =?utf-8?B?ZFpRQlcxbDhLQTR6YllWMnJYd2ZHeWlTaWxZblQrcjE5K2Nxamx0Ri9LQ3pv?=
 =?utf-8?B?a0Nkdjh3MXYvOXdjalJvVFZxMU8xUGpXRk0yS0pVUG1jcVFLL3hwOWsyL1VI?=
 =?utf-8?B?WHJNRUNHV1hxNEQ0dXVkUk9KUEwySU1KQy80Wm5JYlZkTXlLb2hWcUJUT0Iz?=
 =?utf-8?B?TStDY3kxZHU0cnN4NWN1amwwYVplYkI2ejl0N0tjQ3lsL0ZKTmhmM09EK1cw?=
 =?utf-8?B?bUViYjZyTFYxMjVPdXhWbEpYMk1vcXE5dFNNdkdHNk8vQWVEM0VuWGxoMzZq?=
 =?utf-8?B?cmFGUVZzejRUZFZNbXAzNUg3V2hUdFZCNW44RVZHM09GaHpwaytOSWF2QWpu?=
 =?utf-8?B?UmFxUFF2S1hBZmoxTVRvY0NvWkU1dVcvajlha1FweXpZbWxiS1MrMEthU1Fu?=
 =?utf-8?B?d09EK1BUQ211US82VDNZMDByRTN3TXV2M2RMeUIzZ1ZxdVJvZFFkTDF5RzFt?=
 =?utf-8?B?ZEJtZDRVZXFQdmx3OHRsajNHbk93VkdSZ3NlYlNSQVM1TFVLaGdFMWhZZEpF?=
 =?utf-8?B?d0VsZGlhNmJBR1lWSXJBQ0I4RzdOVFBnMFZ6NlJ2ME0rUm5GeHVFS2o0YnpP?=
 =?utf-8?B?UVlaQWlMOUtQd3J3UEdEVVR6eUQ3cnY0TTVld0VYd2VEaG5YaFY3VFgxemJS?=
 =?utf-8?B?ZWRLd0pZb2ltNDlrS1RqRnBsVDJrQm1rMkRyckJjMUFLZkMxTWwvRWFaZHZv?=
 =?utf-8?B?VGJjcFFwY1g0NCtucEJiaGdJWW9jOFIvc1V6Nk84T29HOUtpWjVvd0FhRVZh?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F07DF23858C0248AFCA879488D2281D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Urft+mcNg20pu6GaRsl5E/fMu/8GXjAn4/LzR5FQ0K+KsycV6PflqbrEOreJiTyaPlf0ptcgGSIN8IM0x8/2u3bdkp2mXYCiof89J2u7/dfV8FcsjIMb/66KNrNb8NpQ4BCYryf1l/LWoerSob2zzoJ1geZ3KLNaNVhSN7RPPepNrVNObK+KYelwpSr+NUrWUGwY48ATRtPoPg9/iAUcd6oqmzs3RfKftkBj1iODCDRWNLK+dLHthJRXcTb6XmgtiWzxtPWUinz5uO2ItisofRqfR9WfWWycwtdshbrRuUa8Ac0TAxushtuLtrzNUPeX2ThL/Q3rPF29zhHtbu0d8DAOK1KqXuUeeNvPWJ5ulBu1FNQXOYKSKhegGkUoJrhhyb8dreuLE2RcmzCFUavJGy5w3sXEIE1grjeo9W1wcJkwaE7qyox/2yekqEAvEPkUfASZY+mvM9unP6f21SMLrsYbSIR+LlTAsU2r+ygD9X6FVbfXrON9fW4aPYgtHqUa0mfJ1sYUTb7yptW5lxxJbJtCtxOHQGyx3ECqhuXVNLQy0ATmQDKF+niqre2xeZtT4waoThCGd46jU7TmIBE/7jfx+lAc0CZFEDanz2UPDmmhbwC0IocS29j3GxWUFkuozep1u5W6E3sHXgEL/+wWuvXBFpPb0M3v55Rt8dqic1uO7JuOJuyxvuHAZ9R+ScqgdFffLVDSoLQQgRY788UJIZoCOkH66OiBH5mQTe2ivwLG8BVa83v61iLZp59aVjET6T5VzMw58GWS6awl94RKbHk/X2JL5wNMhmHoaQqVJ9j47Oum+mVysnutjfYh0W3yKQTaGy9/vKzKk0AFVM9/cV4DmAZEoQ2MjpVi4mvRc65UGDtd6lAcf7kgDNh5gO00
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab756d4-5441-484d-19a0-08db4baa8a0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 07:46:43.5235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ErW1rPaz+f9wR6MogHyyf9UEaUNcp2Q6OrL5ABRrad3VtNEFpt/AfZS/GbuRyMMaP5bEgLTKjvLtEk9MYQDH3gPghkxQlTSMVC5P+bVeQMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8163
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
