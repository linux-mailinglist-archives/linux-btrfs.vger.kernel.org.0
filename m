Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54781588296
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 21:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbiHBTgy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 15:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbiHBTgm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 15:36:42 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F93A52E53;
        Tue,  2 Aug 2022 12:36:40 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272I2Vdn019952;
        Tue, 2 Aug 2022 12:36:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=23kwr+UbwBY3Zez8HMpmbVqMYS5tAtB36ZGcJs2CWCw=;
 b=hDn6r76Ft6gmncO+IA9/no90rmyVDjIwkcQqz2ZJVGQNxFNSarI4Fjpo0oHylEqA88lT
 6Amkm6XyBpfq3CF50mJR7FgkHHwXW4ahUvLk+BKY1Pt63C601xhM/Sh1JDICsa77YgC5
 P6DuWWqF00OT+DJCvXTfh+WzdimZqOilNhc= 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hq4b7k2va-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Aug 2022 12:36:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzYTN5B+tyu/RETKkEpEdslNTSNKb9ZBfaU40Tx5IX2iLz0bHvyOaDZsp03y0EErAozJ8yQCFUAIz/UupFEZz6GRbN038bMWYtWnxqh54I7SPkLLH1aW8X5AlhtNZgsGFqsmPMPfPiNw+z8e7N5IThHndJN6j7xE0UrRS7pY5llOdA0N9Y1JBduxZY8+yC50bRW7sg+D9Y2NaMJEAngDMiBECSqGJPT80Ah+4y3v3JDoXda7jtK/l8Aw9spxEJdgW0rcilllHwySYFyTkWZaTf4WmAHErs24W68HFzB70mq8Wyr4VQgA/bXDNTN/8E3vt+ksisYkyOBrlTgcs3+nSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23kwr+UbwBY3Zez8HMpmbVqMYS5tAtB36ZGcJs2CWCw=;
 b=OvkJX7eo1mL6Y3FgoPE0EVHe6sIUKV4+pwUScYjT2KPFnmqYJVYArFtQvx4g2efJkqaiQwmWTXpgI3ifK+2S570yYDFqRSCNz3h+uowBvMRRQ4pvLSmAi0tFwiTxw5RfB4vVIUDRsJgu3PlvD/MR5rDaUod4wrqxBTriaRB0BgTSRPqYjLmfC04MdvAIYerldQlloywILR2cAZA1RIbuD1chb1vDsA7Pi1ncj4OsXPhbNhXcBb5cff342cL46aoJQ0qx/15Jjv9SugGbidJ/dd2ociCaIPK/dYQlAjU6Gy2/sRs32MoxNWpDj4vKS6n6KcosmGFVIvkyC4PpIl2jvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CY4PR15MB1781.namprd15.prod.outlook.com (2603:10b6:910:1f::13)
 by BN8PR15MB2884.namprd15.prod.outlook.com (2603:10b6:408:84::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 2 Aug
 2022 19:36:37 +0000
Received: from CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118]) by CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118%11]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 19:36:36 +0000
From:   "Alex Zhu (Kernel)" <alexlzhu@fb.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Kernel Team <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Chris Mason <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: fix alginment of VMA for memory mapped files on
 THP
Thread-Topic: [PATCH v2] mm: fix alginment of VMA for memory mapped files on
 THP
Thread-Index: AQHYpdc91iPt0edc6E6lZZkF997xNK2b6V4AgAAZTYA=
Date:   Tue, 2 Aug 2022 19:36:36 +0000
Message-ID: <B3F0EB2C-AC3E-4DD5-8D0D-91BC8DE9F5D0@fb.com>
References: <20220801184740.2134364-1-alexlzhu@fb.com>
 <20220802180602.GX13489@twin.jikos.cz>
In-Reply-To: <20220802180602.GX13489@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34ee344d-68cc-4452-4bf2-08da74be506d
x-ms-traffictypediagnostic: BN8PR15MB2884:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H3L1gsFkm4+L6vOc6vTlSfkayIbxnli99DAKMCwHWyKdtgJwiP+GGULRAJsFGmdJMlPh1of4SiNxKvTi1v2nKa6eBpNv/QE/VlXs3CitUw/ntwvOVWvU7qj3Yepk5zcOQx5tZrQ2DLYK24D9ysR8DiE6a8wnKt3PaL/in3T2slzDR3HjmnA568JY0WGfZdlQKK3TNnEuxpHRXffGXjfHNXynneHi2BpHzeIYFgnTQDSmqg3TYGDQqSoIHHxyBziIxk1NoG4v0iut39Idqqa2gcyqy0BW6+8BEg39HqMlKsZPFVOIDvi4JB0mAvvzP9HkZ9hwCs0CFJpk2ujBUMnIAPzkckLAFZU3kl68zOWxj11OhJ2q0whx7muwj9tcXeDqnoztsDPf79/tNkWAEMWWeJdGSqn/0IWjArCxj2K/vr7b+T6nPWqxuEXHARGT60dZvMWHXI/PE6jNQh7BpoST3zX7oHJGgQMjmHPhu8kVDHemTn19rHgR9jk3Yt3MyfsE991QtCsCh6Ul3hToTa4l5VDgfL4ngCbPhLYHQmTg64z9ulq97snoBgCGiSe1En70hqTLhfcY4r9yu6JF0N642BnVolRsrZIiZ70Gb25rcty9ei8s6zrIw300UHVS8LTueyWO+kIioRZ+DhpNPuhGqqUBEZ0+DrKnaFUc9pvkrJGrGBn1vPf3FbiMrmI61Et3jaVb5aLi1djWA7f7A+yvLUQ+iIXZM3895wbJ+kgfRAnp2PTOQG/2jky/SBdkgUeK+7kZPJSWeyZ0MSa5dUYxniSnvIDABfJN3JiPvZ7UNz4vomF3yJrHGYO4BWeYlTxCSiinPYGxZEicM2PWG3wNcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR15MB1781.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(186003)(38070700005)(4744005)(6512007)(66476007)(478600001)(91956017)(76116006)(64756008)(6486002)(66946007)(33656002)(66446008)(8676002)(66556008)(4326008)(5660300002)(71200400001)(8936002)(6506007)(38100700002)(2906002)(41300700001)(54906003)(6916009)(36756003)(2616005)(122000001)(316002)(86362001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjJFMSsrZ3dMWjJNQ244ZWZwN1hSUUpoejJuT2luMmtZRHNONXc5aVhtVmEz?=
 =?utf-8?B?b3k3SVVYeGkvWDZ1ME15Z1ltMkx5T0hsK3JDenJnRm1YaHJyY0QwdC9ITEZH?=
 =?utf-8?B?VUdxNXFxTWtqU2dWeWlkQ1pESUdHRGxPeVhtUERHZG1qSkhuRkQzKy9iSm5R?=
 =?utf-8?B?dzFOMmQ2bkJ5WE0xYUErcTRFelp1bTgyamppUjkzNm5wc1Y4bGRDOXczckFO?=
 =?utf-8?B?K24xa1AxbUNObU54UHpLMjl3RCtTTVF0c2tIanJ5QXVZRk1uVHdvU0xhMzdZ?=
 =?utf-8?B?TmhvM0UxV05RTVg0WVJZYzdSWENHS3lxV0E4ZVcwNkZMaXJkY2FORlh2TW54?=
 =?utf-8?B?UzJlVU5lckVwVEFRalAwaldZckNyeEkzdEpoamY2RVJMOW5xcEZHNlFwM1Vk?=
 =?utf-8?B?TzU1eFBBbXkxVlphNkt2MHE2MldGdWFSM3lUblQrdGRwT1Vpd0F1ODlaai83?=
 =?utf-8?B?SGxqUmJIODh5RFZBbmU2WXNmYWpTOU4wNVAwWFhheFlrZ2FEOTg3MWNxQmJs?=
 =?utf-8?B?djNrVXlLeVo0eHErUk1wdDd6MWVXUUx2SXk1Y2pJWTM3QWd4QnNqQUlXV3Bw?=
 =?utf-8?B?Sjk1RERHWlQwOEFkWWlHSzc0N1hBZ2V3OW9pV29OeHBRc2lJelMwcDRDdHFl?=
 =?utf-8?B?L0R6WUlGZzVqQ2ZIbVg4ZW9CVU9XWHZsTTlaMTJWOFllSE1HTFowNUhVdmhL?=
 =?utf-8?B?WS9MSFdvMS9CL1paUFZhM01taWlCdTZTRVNtUUhZMXRUaS9HdmFFdzJsRy8v?=
 =?utf-8?B?aUd1K2lkQVJkb1kvcEs5NjZ6SGpzbzQ0eGxydGRvWU14aVFyS0IvT1pJMDNU?=
 =?utf-8?B?bGloMUVmWGcwc2xGaVUyZFluSG42aTVTU3FDd2xPSFd6cmtSRG91MU1JWXpF?=
 =?utf-8?B?ejYraGRNREZtaWN2NHdWOS91S012NWU2TXphblF6eHhLSDl1eldYcmFvT0tZ?=
 =?utf-8?B?cmNEQnVEVXdjWkRXSHpuTnIyM1A2eWhYN3pTUkY4b3MvanZQT1FUWnorNkdT?=
 =?utf-8?B?S3RmbDZFaHYwem9KalYzdzhwb29lQnJuTWRZMEcyWkZyWCtRc1NtUWVZdFo3?=
 =?utf-8?B?MVZ3YTNRQ0J0T3VwYkIvZ2dNNzlqZVRDZjduMjVQN0ZCTk9EZkI4R09nQ1lX?=
 =?utf-8?B?K2djNEJSNXhKc0U2eUFVZGxqRVFsamU1cHZIUjk1NzViNGkyN25GMEs0SmN2?=
 =?utf-8?B?OCtwSXp2ZWc0NDlaa1FGdmdTd2paRzVWa2J6T2VZSU1ZRjVrUlFZVE54Y1lk?=
 =?utf-8?B?RHljT05kT1orYzJ2eS9MRFRKMnJ3eGxSeXlITVkvbUk3TEVUeTFwcUx5SVg4?=
 =?utf-8?B?NjBZTjQ1OENTVFI0TTBwUlpPSHNneWR6L0UvSGpqRkJ5amVIZDZlZVFuUjhL?=
 =?utf-8?B?cVVyT2hjVjNZS0lNUnQ4SzZoSnplZXZHZm1kK0YwbVNaYmRncXBoTElNZ2JB?=
 =?utf-8?B?VXdPM2hVSnIyRU4yTUR6Z1NUN3Z5Q0RYcmFFOXNFSndoaHJ1VEtXenZXRkJl?=
 =?utf-8?B?Z1FkbUFGeEZ0TVhKZmpXQm81RnpQS2YzeFNCZXBSdTVJR1RiemxaMVpMaHdF?=
 =?utf-8?B?TitlckNPaU9GTVp3NjhwR3ZuZHZ0N2ZoUXYra21uYmR2bmJ3TTlkOXJpTzRH?=
 =?utf-8?B?Ynl4bkJ1Nk9wVHJCc28vWjBDd1FZaWIvbWU0dkZUYkViY285WktFeVI0WGxX?=
 =?utf-8?B?OHpRNm1sZjVzcis4WHRoOGgvLzBpcXozTWdTNEdSeXNrNjgxblZTTjZ2eURW?=
 =?utf-8?B?Rk9yTENPTk0zd0ZtNVFzeTU5ZjI3YldCbWl5dG5oWjF1U3MrQzdwa0RWbVlj?=
 =?utf-8?B?SkxVVHpjSW54TlRDSUQzRFhwYzRHRzZsQlhpYmVKOEtQNlZqRy91WXRXRkFl?=
 =?utf-8?B?Z3BSbDNmQ0hIMlIzdG9jWndIODVSRTNMc056djh2TDEvU2RkaUdJcnc5L2lF?=
 =?utf-8?B?OWtvUzA0NStyaWV5d2JoT2FGcHhLcHhWOUROWEJiaE1GNUhkblI2b2FCdGhY?=
 =?utf-8?B?QmcvbGx0S01lZ2J1YmRKZ0UwUFExb1R5ZGY4WDRNVmZkMEZuN3lQWitsMXhj?=
 =?utf-8?B?OG9YZWVHUnh0REJJNlJMQ3AyZUZQT3ZWdTVraUNYVVhkRGtCTzF3VzRENGpu?=
 =?utf-8?B?OWtJQkVKcVFnMFZXelN0ZnZraGdPTXQwaGRTRXJSZEl2SHR6UFBDOWtxZ090?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B029B6D970CBEB4892E33C2A2CEEC179@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR15MB1781.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ee344d-68cc-4452-4bf2-08da74be506d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 19:36:36.8138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ahKBtzvzHx68Mcjd3LqASqyHNScPjug3KIWy7S0UXtjPBjF/x1CQLqXnX8sYoSpA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2884
X-Proofpoint-ORIG-GUID: 56xk-qMUI2jkj0a8bmbzmoIW1xsGw89g
X-Proofpoint-GUID: 56xk-qMUI2jkj0a8bmbzmoIW1xsGw89g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_14,2022-08-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQo+IENvbW1pdCBkYmU2ZWM4MTU2NDEgKCJleHQyLzQsIHhmczogY2FsbCB0aHBfZ2V0X3VubWFw
cGVkX2FyZWEoKSBmb3IgcG1kDQo+IG1hcHBpbmdzIikgYWRkcyB0aGUgY2FsbGJhY2sgZm9yIERB
WCwgdGhhdCBidHJmcyBkb2VzIG5vdCBzdXBwb3J0IHNvIGl0DQo+IHdhcyBsZWZ0IG91dC4NCg0K
Q29tbWl0IDE4NTRiYzZlMjQyMCAoIm1tL3JlYWRhaGVhZDogQWxpZ24gZmlsZSBtYXBwaW5ncyBm
b3Igbm9uLURBWOKAnSkgcmVtb3ZlZCB0aGUgREFYIHJlcXVpcmVtZW50LiANCldlIHNob3VsZCBu
b3cgYmUgYWJsZSB0byBjYWxsIHRocF9nZXRfdW5tYXBwZWRfYXJlYSgpIGZvciBidHJmcy4NCg0K
SeKAmWxsIHNlbmQgb3V0IGEgdjMgd2l0aCB0aGUgc3ViamVjdCBhbmQgc2lnbiBvZmYgY29ycmVj
dGVkLiBUaGFua3MhIA0KDQo=
