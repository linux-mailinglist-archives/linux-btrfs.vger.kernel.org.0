Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111CD57BC62
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jul 2022 19:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiGTRMM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jul 2022 13:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGTRML (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jul 2022 13:12:11 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1116D9D8
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 10:12:10 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KBClxm029244
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 10:12:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=r8FmSl0aWSraZN/MC79j/Gl8lgVgZoltdbRsgxNlXqw=;
 b=X49eMRtvase/KdM0fF5wHeayXye2J3Myq0eYcwSF3jHE+vM/hJLdavdm8lnHHdfXhSaD
 VHG1PidRwo5ulMBACbprtuKM1IHPwBzWw9NLWL32vqO0K401Oc+moG59F7pRB8gWKGGF
 IK2sMlyXivor2vi+2Tgzzmz2yeqw05ztLkM= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hegmpa6bh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 10:12:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWFzmBY6fYDPagCibPXfLpLw63UsUVan+qZM9kYfwsfM96bRRzj2i1Zng1qZUXWvtR7Ipyth5Bd+Sn8ilLuiDgbtXx3J9Nxy6NzhefjeKFTuk9WDKtpMo+HXbmpMPqgo/xKcC/cw6r8I0voU/GhbwpPsFQhzWur/1oV+fJron0MxhwHXm0gECOGDmIE8xhCGCxHSP7WDWUm2R8NyQGuxZZSxWVRa7M49I2SgnQDG4qc5VdBO70jTr0ynURhTdq46A/vMExRZhFp5b36gQ+W7mKbhvCVmT/UdQjGrAjLHdEBF7Z2bKdXw+V/SrFvsPmFQTkD1Kt+uraWC93E9CFTCtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8FmSl0aWSraZN/MC79j/Gl8lgVgZoltdbRsgxNlXqw=;
 b=bYeQpVqEqbK7ut7zQyUgr4GMOIZZyYoSeJXh0CrhVLCZPxCANy/hFHaA4y+FF6hrkzmp/b8y16YFNNO/R/6sf56JVK9CMMG2z/f6XfvDzFiLBuj5WfcTSlWRQjsJDqdbJVrL4fb0X20/tCQnjrEszpvarubu36l51kcamtbTtXZgJQtE90LEC0GKO9d0QeIra33SmWWPIac1F8vSmImOxymqciYIfB/321EvOP2fqj9DpV3VJvYfTAKXhJjbfzM0jwqhaDo4RDmQshqkjXZ5UlfRYF/mo/tZNbvdq7w6s5+quSNRsVp+1zFyA/a2AufuzKzL1Qh12mxlWUfAQkR72w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BN8PR15MB2852.namprd15.prod.outlook.com (2603:10b6:408:8d::10)
 by SN6PR15MB2335.namprd15.prod.outlook.com (2603:10b6:805:24::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 20 Jul
 2022 17:12:06 +0000
Received: from BN8PR15MB2852.namprd15.prod.outlook.com
 ([fe80::69cb:5bc4:7861:dfef]) by BN8PR15MB2852.namprd15.prod.outlook.com
 ([fe80::69cb:5bc4:7861:dfef%7]) with mapi id 15.20.5458.018; Wed, 20 Jul 2022
 17:12:05 +0000
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v2 1/5] btrfs: Add a lockdep model for the num_writers
 wait event
Thread-Topic: [PATCH v2 1/5] btrfs: Add a lockdep model for the num_writers
 wait event
Thread-Index: AQHYnEeY5rUiU55+4EWz2ShRodzCCa2HfxsA
Date:   Wed, 20 Jul 2022 17:12:05 +0000
Message-ID: <696921d4-7f5a-2110-0aa1-dbb5a4d73222@fb.com>
References: <20220719040954.3964407-1-iangelak@fb.com>
 <20220719040954.3964407-2-iangelak@fb.com>
 <4f52398b-4238-7d90-df30-a5073c411b36@dorminy.me>
In-Reply-To: <4f52398b-4238-7d90-df30-a5073c411b36@dorminy.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e76a9f32-c1d6-470c-2708-08da6a72f87a
x-ms-traffictypediagnostic: SN6PR15MB2335:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2A4DleO4dSW71C0KfU/9PZef5Y4Oz/xcG7dFKONMdln7Qa65LX8uNNxgKdGlsOyDQl4BLRg0eXX9dttyEP8dDCRCXNyEIXGF+aVSBO9mkUgRfoRaZkXjI3NVwAW+B8eqKccQok3YgGHXYGyhxxUSPvBreZi4GrS/PHjgP7c13AKJxoBpW5KN2rk4P5ZMTXy1edNCJhmR1TRfQ8Ni25MPxp+ZTiJ9WY8G1iy0rUIepOJGA+Zo/eagE8XIGrxgP0ZBBVJThzkMyYmoeVidfksGLTEWquq2N1vCoVoefqTCoF6+Nzk3EQLDkQ4yVMXQ3Dmp4op2p10BAURedzrVZR8u8Sf8bhW8cx+sMzy1NJrUG0PM0+4F0IPuTR5pxt2WMLkmMmq3JZNzZcH/PQEgYxs9gkHxIlGwFw8NkDWb1hEWY3bdfxWgoSERHZhEq+NS4UVBD1GWHOroXjTda0HtXWMDOYbmrlDU4gMko5XdxZc8l0iHk2NWLgdb067OdJ7ZQ21WxjNVewQVHKJgUunMR1TvXsqiSTCorWNSDROP90gtUgZ8k8RwSr+6kQJV2gMgoPbedQMwpGCn+34a5BWNMSCBQSrzTnYusjzp3nsnM9GnXrWfKLDn9t3KeUO09287kNhaoSk7v49+X68AARM6ZGR/chdWghzGLCajkAeNMIiV71GWm4zUnN64q83BctDzU7Y8xU4MZ9SsNal8pM/eKUKMc7GN24qa8uTh/bD5mWBSMLLlrPGaXZIHmmCxeraKFzrxJkSNAgrey9sot/W7kmdladZCyETYHJTNUyO7YErNYtpYNk/cI5hwu6vnksMew/5S/tUOF3nA0D3BybOYDLgB6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2852.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(36756003)(31696002)(86362001)(6512007)(122000001)(2616005)(41300700001)(38100700002)(6506007)(31686004)(38070700005)(83380400001)(53546011)(186003)(316002)(6486002)(110136005)(64756008)(6636002)(66476007)(66556008)(66446008)(8676002)(71200400001)(66946007)(91956017)(478600001)(76116006)(5660300002)(2906002)(30864003)(8936002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2UrR2xneFFqSnU0OEhUckVxRSt4WTBoWUwvdGoxTEVETHZVdHgxR2NYNFRr?=
 =?utf-8?B?RjkyUlEvSE42TnBEY3pQUUVET0FIV0RTem1Ra1hDNXVJQWFoVDllb1hkTVB5?=
 =?utf-8?B?dDB3NmpicWtDY2x3SnZYYUp3aC9rN2RGL3J3ZHNBRncxZ3FNVGQ2eDV6RnVl?=
 =?utf-8?B?Yjk0QldwUmx1OTZ2amVhM1QyYTNXWnlienVFajY0ekUxQWpzMThPTmJiVndp?=
 =?utf-8?B?dVhkc0taNXFGUmtIY0Q4d3ZkNE1yd1Q2Vi92eXdGZ3ZUWlZYNTBjTytFenNW?=
 =?utf-8?B?V1lYZFQ2dTJPZlNpVE83bm0zbk1BTlNKbEJqdkxNSHZCa3dMRjVtbkx6akFC?=
 =?utf-8?B?LzU5ZG5nN1JsMHVXWUlEWVBweE94a3BWV0trdGMyMTNnNHVlV0N2NWtyOHlv?=
 =?utf-8?B?QlhMajRWYWpHYkNUdHhuYmsvaHlhbmI4K0h6NXBNM3JMNzE1bnpnMlAxNWxa?=
 =?utf-8?B?c0dQSFpCSDFQRmlXamRDNmNPUmh6SGpOMUE4aVlqQ0VmVkZYTDZYWVJYbE8w?=
 =?utf-8?B?VEsvRmovNW5IdkpoSWtZVFg4UE1CSzJsMWpyTVFpTUZWMkl6OG9xbFhnVjVu?=
 =?utf-8?B?WUd3dkc0aVl6ZVZLaVhOSk9RRzhidTNBcmN4dElvQlg3Y0Rselc3Sm1BeUVl?=
 =?utf-8?B?MjlVZGNraEw0ZkMrNmt0UEpvMkRzTXNSYURERUtTaHQrMlV0TStacE5aa0N1?=
 =?utf-8?B?cHN4TGljSjJ1OWFDREw4Y2FrS1pJMzBHTk5tUzgrUkVJZ2pDeGxFczdTYnJO?=
 =?utf-8?B?ZTB6Z2IxRFJ6bElweFJBVDRGSUZpVzdYSVcyUmQ2YnZNejg3dHp4ZXJ3WXp4?=
 =?utf-8?B?czV5Yys3dGF2a0Y2OFUrTUJsejhNZjRMVnJwUTFIc2FrcFk3K2xSVDVmSGgx?=
 =?utf-8?B?Qk5tT2llczhEczBmTVBCOVJYeDEvWGZveUpLSXk1T0oyYk8rTU1NUEFnU0ZX?=
 =?utf-8?B?Y1BnQmh0V0F5aVptQ1U3NllzaTBmazBlLzBxZVpjTEZRMHk1d3lQSW1kL2pk?=
 =?utf-8?B?blg5MDI1a0duTkNkc1VhWVhrdWphYW9jd0ViTi9mdDg2U0JDVlVvUlByc0RQ?=
 =?utf-8?B?Nkl0Mnl6dG0rLzVRblBMSG9sRm5TRXZ4bFpKUTRMSnMxQ2JoQ0F6OTZza1VF?=
 =?utf-8?B?VmUyeTJvUUNpY3kvcC9RYThtWVc2UWtBQU5FcnRtTnczajVsaVhLbFovSHFs?=
 =?utf-8?B?enBuRmQ2aTFOSUdHbmhLQTJLSGxiUHZHRUZudWxVL1NxbEpnSWlhRkFrS1RZ?=
 =?utf-8?B?SnhGWXdLZ3hqcXBPZFhUQUd0S0UvZ1cvR0hzSlNIOG9xK1dzVFIxNE9vMTNZ?=
 =?utf-8?B?MWlGM2kxeEdqbVVMTEJJZ3h3ejFqS1g4Wk9WNzlPa0NpbjZXTzI1cU0wRFYy?=
 =?utf-8?B?L0I2NTF2WC90cXVRNytNSVhWa3pXeThWclZhRUJYQUovSjVQWExqb05EdnBG?=
 =?utf-8?B?L2tuMDZDUGZwanA5cGtCcm1kSE4zbWpUMGJiazdQTFZ1dWIzMUdkNmEvTjhZ?=
 =?utf-8?B?ZnNySkVsSmpUdnY4aEZzTlh3TzVkT1NOSUNUYWtIZytCWkwwc3ZlbHl0bWFm?=
 =?utf-8?B?YUREb0JocGd5TEtwQm1wNFF3V0Y4S3hIckJIMDNDM0RsQjFPaFdqRy9IUGpN?=
 =?utf-8?B?dlFTL3pxbEswMWNCUGthVG9OZEl4WnM1Wld5UmRRYWJqemszNE1GdWk5cVZD?=
 =?utf-8?B?RWtRcTArMDhOYTN0aTkyVlBBemZrU2RoYVZJVWRnY3dVbDNxTVVVczZ6aTdW?=
 =?utf-8?B?eGk0ZldDZXZRbGtjU3ZTWEtDWnk2U1luUUxEYUNvMmFsVG1jMVZ3bkc3Wnc5?=
 =?utf-8?B?eERnYy85NEkwNVVBNDFISDcyRjJSbUFMOTVxenNDY0JkL2RBK1UzKzhTT3Aw?=
 =?utf-8?B?OW93SVN1Q2NTTXovbUwyYlhlYXBMNTVjMlB3WnpSM2piOTU0SW81WjhKVjVa?=
 =?utf-8?B?UGp4b2N6RHBBVWtNcWRTRG1KRnZ2bHNFbVV2N0d5a2tUeEtTZFVjWCswVjh3?=
 =?utf-8?B?RVJlMWFwbUpIZWsvcVVqbXRmLzJVaDZUYmR5ZG9JbkI0bHRLOE9LUzhUbVpN?=
 =?utf-8?B?OEVOWU9oVGwyU3ozb3JIalMycFgvMnF6ZEtOTTNLaGp3dDBBWnNOYWdJdHEy?=
 =?utf-8?B?T2w3UzdGQWQwc0tTN2pLdXltL0RqVWhuSUdnNTRIVnhQOStnczFQcks0WWVM?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9DFA4C0754EE64887C3DB4190F71774@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB2852.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e76a9f32-c1d6-470c-2708-08da6a72f87a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 17:12:05.3448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +cykod/ERAPUqzhHfUu2K0uu4BZUmdMjFiJL1zzAAcXpCO+2zqBTp1ySXXMstSrt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2335
X-Proofpoint-ORIG-GUID: oho8mhcdk7pQtHg6XHwNTUqraDogz10Y
X-Proofpoint-GUID: oho8mhcdk7pQtHg6XHwNTUqraDogz10Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_10,2022-07-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gNy8yMC8yMiA3OjQ3IEFNLCBTd2VldCBUZWEgRG9ybWlueSB3cm90ZToNCj4gDQo+IA0KPiBP
biA3LzE5LzIyIDAwOjA5LCBJb2FubmlzIEFuZ2VsYWtvcG91bG9zIHdyb3RlOg0KPj4gQW5ub3Rh
dGUgdGhlIG51bV93cml0ZXJzIHdhaXQgZXZlbnQgaW4gZnMvYnRyZnMvdHJhbnNhY3Rpb24uYyB3
aXRoIA0KPj4gbG9ja2RlcA0KPj4gaW4gb3JkZXIgdG8gY2F0Y2ggZGVhZGxvY2tzIGludm9sdmlu
ZyB0aGlzIHdhaXQgZXZlbnQuDQo+Pg0KPj4gVXNlIGEgcmVhZC93cml0ZSBsb2NrZGVwIG1hcCBm
b3IgdGhlIGFubm90YXRpb24uIEEgdGhyZWFkIA0KPj4gc3RhcnRpbmcvam9pbmluZw0KPj4gdGhl
IHRyYW5zYWN0aW9uIGFjcXVpcmVzIHRoZSBtYXAgYXMgYSByZWFkZXIgd2hlbiBpdCBpbmNyZW1l
bnRzDQo+PiBjdXJfdHJhbnMtPm51bV93cml0ZXJzIGFuZCBpdCBhY3F1aXJlcyB0aGUgbWFwIGFz
IGEgd3JpdGVyIGJlZm9yZSBpdA0KPj4gYmxvY2tzIG9uIHRoZSB3YWl0IGV2ZW50cw0KPiANCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBJb2FubmlzIEFuZ2VsYWtvcG91bG9zIDxpYW5nZWxha0BmYi5j
b20+DQo+PiAtLS0NCj4+IMKgIGZzL2J0cmZzL2N0cmVlLmjCoMKgwqDCoMKgwqAgfCAxNCArKysr
KysrKysrKysrKw0KPj4gwqAgZnMvYnRyZnMvZGlzay1pby5jwqDCoMKgwqAgfMKgIDYgKysrKysr
DQo+PiDCoCBmcy9idHJmcy90cmFuc2FjdGlvbi5jIHwgMzcgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0tLQ0KPj4gwqAgMyBmaWxlcyBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCsp
LCA1IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9mcy9idHJmcy9jdHJlZS5oIGIv
ZnMvYnRyZnMvY3RyZWUuaA0KPj4gaW5kZXggMjAyNDk2MTcyMDU5Li45OTk4Njg3MzRiZTcgMTAw
NjQ0DQo+PiAtLS0gYS9mcy9idHJmcy9jdHJlZS5oDQo+PiArKysgYi9mcy9idHJmcy9jdHJlZS5o
DQo+PiBAQCAtMTA5NSw2ICsxMDk1LDggQEAgc3RydWN0IGJ0cmZzX2ZzX2luZm8gew0KPj4gwqDC
oMKgwqDCoCAvKiBVcGRhdGVzIGFyZSBub3QgcHJvdGVjdGVkIGJ5IGFueSBsb2NrICovDQo+PiDC
oMKgwqDCoMKgIHN0cnVjdCBidHJmc19jb21taXRfc3RhdHMgY29tbWl0X3N0YXRzOw0KPj4gK8Kg
wqDCoCBzdHJ1Y3QgbG9ja2RlcF9tYXAgYnRyZnNfdHJhbnNfbnVtX3dyaXRlcnNfbWFwOw0KPj4g
Kw0KPj4gwqAgI2lmZGVmIENPTkZJR19CVFJGU19GU19SRUZfVkVSSUZZDQo+PiDCoMKgwqDCoMKg
IHNwaW5sb2NrX3QgcmVmX3ZlcmlmeV9sb2NrOw0KPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgcmJfcm9v
dCBibG9ja190cmVlOw0KPj4gQEAgLTExNzUsNiArMTE3NywxOCBAQCBlbnVtIHsNCj4+IMKgwqDC
oMKgwqAgQlRSRlNfUk9PVF9VTkZJTklTSEVEX0RST1AsDQo+PiDCoCB9Ow0KPj4gKyNkZWZpbmUg
YnRyZnNfbWlnaHRfd2FpdF9mb3JfZXZlbnQoYiwgbG9jaykgXA0KPj4gK8KgwqDCoCBkbyB7IFwN
Cj4+ICvCoMKgwqDCoMKgwqDCoCByd3NlbV9hY3F1aXJlKCZiLT5sb2NrIyNfbWFwLCAwLCAwLCBf
VEhJU19JUF8pOyBcDQo+PiArwqDCoMKgwqDCoMKgwqAgcndzZW1fcmVsZWFzZSgmYi0+bG9jayMj
X21hcCwgX1RISVNfSVBfKTsgXA0KPj4gK8KgwqDCoCB9IHdoaWxlICgwKQ0KPj4gKw0KPiBUaGlz
IGNvbmZ1c2VzIG1lIGEgbG90LiBidHJmc19taWdodF93YWl0X2Zvcl9ldmVudCgpIGRvZXNuJ3Qg
aGF2ZSB0aGUgDQo+IHNhbWUgbG9ja2RlcCBwcmVmaXggdGhhdCB0aGUgb3RoZXIgYW5ub3RhdGlv
bnMgZG8sIHNvIGl0J3Mgbm90IG9idmlvdXMgDQo+IHJlYWRpbmcgdGhlIGNhbGxzaXRlcyB0aGF0
IGl0J3MgbG9ja2RlcC1yZWxhdGVkLiBJIGFsc28gZG9uJ3QgdW5kZXJzdGFuZCANCj4gd2hhdCBw
YXJhbWV0ZXJzIEkgc2hvdWxkIHBhc3MgdGhpcyBmdW5jdGlvbiBlYXNpbHksIHNvIGEgY29tbWVu
dCB3b3VsZCANCj4gYmUgbmljZS4NCj4gDQo+IEFuZCBJIHRoaW5rLCBhZnRlciByZWFkaW5nIGxv
Y2tkZXAgY29kZSwgSSB1bmRlcnN0YW5kIHdoeSBpdCdzIA0KPiByd3NlbV9hY3F1aXJlKCkgaGVy
ZSwgdnMgcndzZW1fYWNxdWlyZV9yZWFkKCkgYmVsb3csIGJ1dCBpdCBtaWdodCBiZSANCj4gbmlj
ZSB0byBoYXZlIGEgY29tbWVudCBibG9jayBleHBsYWluaW5nIHdoeSB0aGVyZSdzIGEgZGlmZmVy
ZW5jZSBpbiANCj4gd2hpY2ggb25lIGlzIGNhbGxlZC4NCj4gDQpUaGUgcndzZW1fYWNxdWlyZV9y
ZWFkIGlzIHRvIGFjcXVpcmUgYSBzaGFyZWQgbG9jayAocmVhZGVyKSwgYW5kIHRoZSANCnJ3c2Vt
X2FjcXVpcmUgaXMgdG8gYWNxdWlyZSBhbiBleGNsdXNpdmUgbG9jayAod3JpdGVyKS4gVGhyZWFk
cyB0aGF0IA0KbW9kaWZ5IHRoZSBjb25kaXRpdGlvbiB0YWtlIHRoZSBsb2NrIGFzIHJlYWRlcnMg
d2hpbGUgdGhlIGNvbmRpdGlvbiBpcyANCmZhbHNlIGFuZCByZWxlYXNlIGl0IGFmdGVyIHRoZSBj
b25kaXRpb24gaXMgc2lnbmFsZWQuIFRoZSB0aHJlYWRzIHRoYXQgDQptaWdodCBibG9jayBvbiB0
aGUgd2FpdCBldmVudCB0YWtlIHRoZSBsb2NrIGFzIHdyaXRlcnMsIG1lYW5pbmcgdGhhdCANCnRo
ZXkgc2hvdWxkIGZpcnN0IGJsb2NrIG9uIHRoZSBsb2NrIHVudGlsIGFsbCB0aGUgcmVhZGVyIHRo
cmVhZHMgDQpyZWxlYXNlZCB0aGVpciBsb2Nrcy4NCg0KPiAoU3R5bGlzdGljYWxseSwgaXQgd291
bGQgYmUgbmljZSBJTU8gZm9yIGFsbCBvZiB0aGUgc2xhc2hlcyB0byBiZSBsaW5lZCANCj4gdXAg
dmVydGljYWxseSwgYSBsYSB0cmVlLWNoZWNrZXIuYzoxMDIpDQo+IA0KPj4gKyNkZWZpbmUgYnRy
ZnNfbG9ja2RlcF9hY3F1aXJlKGIsIGxvY2spIFwNCj4+ICvCoMKgwqAgcndzZW1fYWNxdWlyZV9y
ZWFkKCZiLT5sb2NrIyNfbWFwLCAwLCAwLCBfVEhJU19JUF8pDQo+PiArDQo+IFJlYWRpbmcgdGhl
IGxvY2tkZXAgc3R1ZmYsIGl0IHNlZW1zIHRoYXQgdGhleSBkcmF3IGRpc3RpbmN0aW9uIGJldHdl
ZW4gDQo+IF9hY3F1aXJlIGFuZCBfYWNxdWlyZV9yZWFkLiBNYXliZSB3b3J0aCBhIGNvbW1lbnQg
dG8gbm90ZSBhbGwgdGhlIA0KPiBub3Rpb25hbCBsb2NrcyBzdGFydCBvZmYgc2hhcmVkIGFuZCBv
bmx5IGJlY29tZSBleGNsdXNpdmUgaW4gDQo+IGJ0cmZzX21pZ2h0X3dhaXRfZm9yX2V2ZW50KCk/
DQo+DQpZZXMsIEkgY2FuIHB1dCBhIGNvbW1lbnQgc3BlY2lmeWluZyB3aGVyZSBlYWNoIGxvY2sg
aXMgdGFrZW4gYXMgDQpleHBsYWluZWQgYWJvdmUuDQoNCj4+ICsjZGVmaW5lIGJ0cmZzX2xvY2tk
ZXBfcmVsZWFzZShiLCBsb2NrKSBcDQo+PiArwqDCoMKgIHJ3c2VtX3JlbGVhc2UoJmItPmxvY2sj
I19tYXAsIF9USElTX0lQXykNCj4+ICsNCj4+IMKgIHN0YXRpYyBpbmxpbmUgdm9pZCBidHJmc193
YWtlX3VuZmluaXNoZWRfZHJvcChzdHJ1Y3QgYnRyZnNfZnNfaW5mbyANCj4+ICpmc19pbmZvKQ0K
Pj4gwqAgew0KPj4gwqDCoMKgwqDCoCBjbGVhcl9hbmRfd2FrZV91cF9iaXQoQlRSRlNfRlNfVU5G
SU5JU0hFRF9EUk9QUywgJmZzX2luZm8tPmZsYWdzKTsNCj4+IGRpZmYgLS1naXQgYS9mcy9idHJm
cy9kaXNrLWlvLmMgYi9mcy9idHJmcy9kaXNrLWlvLmMNCj4+IGluZGV4IDNmYWM0MjljZjhhNC4u
MDFhNWE0OWEzYTExIDEwMDY0NA0KPj4gLS0tIGEvZnMvYnRyZnMvZGlzay1pby5jDQo+PiArKysg
Yi9mcy9idHJmcy9kaXNrLWlvLmMNCj4+IEBAIC0zMDQ2LDYgKzMwNDYsOCBAQCBzdGF0aWMgaW50
IF9fY29sZCBpbml0X3RyZWVfcm9vdHMoc3RydWN0IA0KPj4gYnRyZnNfZnNfaW5mbyAqZnNfaW5m
bykNCj4+IMKgIHZvaWQgYnRyZnNfaW5pdF9mc19pbmZvKHN0cnVjdCBidHJmc19mc19pbmZvICpm
c19pbmZvKQ0KPj4gwqAgew0KPj4gK8KgwqDCoCBzdGF0aWMgc3RydWN0IGxvY2tfY2xhc3Nfa2V5
IGJ0cmZzX3RyYW5zX251bV93cml0ZXJzX2tleTsNCj4+ICsNCj4+IMKgwqDCoMKgwqAgSU5JVF9S
QURJWF9UUkVFKCZmc19pbmZvLT5mc19yb290c19yYWRpeCwgR0ZQX0FUT01JQyk7DQo+PiDCoMKg
wqDCoMKgIElOSVRfUkFESVhfVFJFRSgmZnNfaW5mby0+YnVmZmVyX3JhZGl4LCBHRlBfQVRPTUlD
KTsNCj4+IMKgwqDCoMKgwqAgSU5JVF9MSVNUX0hFQUQoJmZzX2luZm8tPnRyYW5zX2xpc3QpOw0K
Pj4gQEAgLTMwNzQsNiArMzA3NiwxMCBAQCB2b2lkIGJ0cmZzX2luaXRfZnNfaW5mbyhzdHJ1Y3Qg
YnRyZnNfZnNfaW5mbyANCj4+ICpmc19pbmZvKQ0KPj4gwqDCoMKgwqDCoCBtdXRleF9pbml0KCZm
c19pbmZvLT56b25lZF9kYXRhX3JlbG9jX2lvX2xvY2spOw0KPj4gwqDCoMKgwqDCoCBzZXFsb2Nr
X2luaXQoJmZzX2luZm8tPnByb2ZpbGVzX2xvY2spOw0KPj4gK8KgwqDCoCBsb2NrZGVwX2luaXRf
bWFwKCZmc19pbmZvLT5idHJmc190cmFuc19udW1fd3JpdGVyc19tYXAsDQo+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiYnRyZnNfdHJhbnNfbnVtX3dyaXRlcnMi
LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmJ0cmZzX3Ry
YW5zX251bV93cml0ZXJzX2tleSwgMCk7DQo+IFNvcnQgb2YgYSBub24tc3RhbmRhcmQgaW5kZW50
YXRpb24sIGFzIGZhciBhcyBJIGtub3cuIE1pZ2h0IEkgc3VnZ2VzdCANCj4gbGluaW5nIHVwIHRo
ZSBzZWNvbmQgYW5kIHRoaXJkIGxpbmVzIGxpa2Ugc286DQoNClNvcnJ5IGZvciB0aGlzLiBJdCBt
aWdodCBiZSBhIHByb2JsZW0gd2l0aCBteSBlZGl0b3IgYW5kIEkgd2lsbCBhZGRyZXNzIGl0Lg0K
PiArwqDCoMKgIGxvY2tkZXBfaW5pdF9tYXAoJmZzX2luZm8tPmJ0cmZzX3RyYW5zX251bV93cml0
ZXJzX21hcCwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiYnRyZnNfdHJhbnNfbnVtX3dy
aXRlcnMiLA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZidHJmc190cmFuc19udW1fd3Jp
dGVyc19rZXksIDApOw0KPiANCj4gQWxzbywgaXQgbG9va3MgbGlrZSB5b3UgY2FsbCB0aGlzIGZ1
bmN0aW9uIHdpdGggdGhlIHNhbWUgc29ydCBvZiBwYXR0ZXJuIA0KPiBpbiBhbGwgdGhlIHBhdGNo
ZXMuIFlvdSBjb3VsZCBtYWtlIGEgbWFjcm8gdGhhdCBkb2VzIHNvbWV0aGluZyBsaWtlIA0KPiAo
dW50ZXN0ZWQpDQo+IGRvIHsNCj4gIMKgwqDCoMKgc3RhdGljIHN0cnVjdCBsb2NrX2NsYXNzX2tl
eSBsb2NrbmFtZSMjX2tleQ0KPiAgwqDCoMKgwqBsb2NrZGVwX2luaXRfbWFwKCZmc19pbmZvLT5s
b2NrbmFtZSMjX21hcCwgbG9ja25hbWUsDQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmxv
Y2tuYW1lIyNfa2V5LCAwKTsNCj4gfSB3aGlsZSAoMCk7DQo+IGFuZCBub3QgaGF2ZSB0byBzZXBh
cmF0ZWx5IGRlZmluZSB0aGUga2V5cy4NCllvdSBhcmUgcmlnaHQgdGhpcyBsb29rcyBjbGVhbmVy
LiBJIHdpbGwgdGVzdCBpdCBhbmQgaWYgaXQgd29ya3MgSSB3aWxsIA0KaW5jbHVkZSBpdCBpbiB0
aGUgbmV4dCB2ZXJzaW9uIG9mIHRoZSBwYXRjaGVzLg0KPiANCj4gDQo+PiArDQo+PiDCoMKgwqDC
oMKgIElOSVRfTElTVF9IRUFEKCZmc19pbmZvLT5kaXJ0eV9jb3dvbmx5X3Jvb3RzKTsNCj4+IMKg
wqDCoMKgwqAgSU5JVF9MSVNUX0hFQUQoJmZzX2luZm8tPnNwYWNlX2luZm8pOw0KPj4gwqDCoMKg
wqDCoCBJTklUX0xJU1RfSEVBRCgmZnNfaW5mby0+dHJlZV9tb2Rfc2VxX2xpc3QpOw0KPj4gZGlm
ZiAtLWdpdCBhL2ZzL2J0cmZzL3RyYW5zYWN0aW9uLmMgYi9mcy9idHJmcy90cmFuc2FjdGlvbi5j
DQo+PiBpbmRleCAwYmVjMTA3NDBhZDMuLmQ4Mjg3ZWM4OTBiYyAxMDA2NDQNCj4+IC0tLSBhL2Zz
L2J0cmZzL3RyYW5zYWN0aW9uLmMNCj4+ICsrKyBiL2ZzL2J0cmZzL3RyYW5zYWN0aW9uLmMNCj4+
IEBAIC0zMTMsNiArMzEzLDcgQEAgc3RhdGljIG5vaW5saW5lIGludCBqb2luX3RyYW5zYWN0aW9u
KHN0cnVjdCANCj4+IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8sDQo+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgYXRvbWljX2luYygmY3VyX3RyYW5zLT5udW1fd3JpdGVycyk7DQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgZXh0d3JpdGVyX2NvdW50ZXJfaW5jKGN1cl90cmFucywgdHlwZSk7DQo+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgc3Bpbl91bmxvY2soJmZzX2luZm8tPnRyYW5zX2xvY2spOw0KPj4gK8KgwqDC
oMKgwqDCoMKgIGJ0cmZzX2xvY2tkZXBfYWNxdWlyZShmc19pbmZvLCBidHJmc190cmFuc19udW1f
d3JpdGVycyk7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7DQo+PiDCoMKgwqDCoMKg
IH0NCj4+IMKgwqDCoMKgwqAgc3Bpbl91bmxvY2soJmZzX2luZm8tPnRyYW5zX2xvY2spOw0KPj4g
QEAgLTMzNCwxNiArMzM1LDIwIEBAIHN0YXRpYyBub2lubGluZSBpbnQgam9pbl90cmFuc2FjdGlv
bihzdHJ1Y3QgDQo+PiBidHJmc19mc19pbmZvICpmc19pbmZvLA0KPj4gwqDCoMKgwqDCoCBpZiAo
IWN1cl90cmFucykNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT01FTTsNCj4+ICvC
oMKgwqAgYnRyZnNfbG9ja2RlcF9hY3F1aXJlKGZzX2luZm8sIGJ0cmZzX3RyYW5zX251bV93cml0
ZXJzKTsNCj4+ICsNCj4+IMKgwqDCoMKgwqAgc3Bpbl9sb2NrKCZmc19pbmZvLT50cmFuc19sb2Nr
KTsNCj4+IMKgwqDCoMKgwqAgaWYgKGZzX2luZm8tPnJ1bm5pbmdfdHJhbnNhY3Rpb24pIHsNCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCAvKg0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBzb21lb25l
IHN0YXJ0ZWQgYSB0cmFuc2FjdGlvbiBhZnRlciB3ZSB1bmxvY2tlZC7CoCBNYWtlIHN1cmUNCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgICogdG8gcmVkbyB0aGUgY2hlY2tzIGFib3ZlDQo+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAqLw0KPj4gK8KgwqDCoMKgwqDCoMKgIGJ0cmZzX2xvY2tkZXBfcmVs
ZWFzZShmc19pbmZvLCBidHJmc190cmFuc19udW1fd3JpdGVycyk7DQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAga2ZyZWUoY3VyX3RyYW5zKTsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGxvb3A7
DQo+PiDCoMKgwqDCoMKgIH0gZWxzZSBpZiAoQlRSRlNfRlNfRVJST1IoZnNfaW5mbykpIHsNCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCBzcGluX3VubG9jaygmZnNfaW5mby0+dHJhbnNfbG9jayk7DQo+
PiArwqDCoMKgwqDCoMKgwqAgYnRyZnNfbG9ja2RlcF9yZWxlYXNlKGZzX2luZm8sIGJ0cmZzX3Ry
YW5zX251bV93cml0ZXJzKTsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBrZnJlZShjdXJfdHJhbnMp
Ow0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRVJPRlM7DQo+PiDCoMKgwqDCoMKgIH0N
Cj4+IEBAIC0xMDIyLDYgKzEwMjcsOSBAQCBzdGF0aWMgaW50IF9fYnRyZnNfZW5kX3RyYW5zYWN0
aW9uKHN0cnVjdCANCj4+IGJ0cmZzX3RyYW5zX2hhbmRsZSAqdHJhbnMsDQo+PiDCoMKgwqDCoMKg
IGV4dHdyaXRlcl9jb3VudGVyX2RlYyhjdXJfdHJhbnMsIHRyYW5zLT50eXBlKTsNCj4+IMKgwqDC
oMKgwqAgY29uZF93YWtlX3VwKCZjdXJfdHJhbnMtPndyaXRlcl93YWl0KTsNCj4+ICsNCj4+ICvC
oMKgwqAgYnRyZnNfbG9ja2RlcF9yZWxlYXNlKGluZm8sIGJ0cmZzX3RyYW5zX251bV93cml0ZXJz
KTsNCj4+ICsNCj4+IMKgwqDCoMKgwqAgYnRyZnNfcHV0X3RyYW5zYWN0aW9uKGN1cl90cmFucyk7
DQo+PiDCoMKgwqDCoMKgIGlmIChjdXJyZW50LT5qb3VybmFsX2luZm8gPT0gdHJhbnMpDQo+PiBA
QCAtMTk5NCw2ICsyMDAyLDEyIEBAIHN0YXRpYyB2b2lkIGNsZWFudXBfdHJhbnNhY3Rpb24oc3Ry
dWN0IA0KPj4gYnRyZnNfdHJhbnNfaGFuZGxlICp0cmFucywgaW50IGVycikNCj4+IMKgwqDCoMKg
wqAgaWYgKGN1cl90cmFucyA9PSBmc19pbmZvLT5ydW5uaW5nX3RyYW5zYWN0aW9uKSB7DQo+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgY3VyX3RyYW5zLT5zdGF0ZSA9IFRSQU5TX1NUQVRFX0NPTU1JVF9E
T0lORzsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBzcGluX3VubG9jaygmZnNfaW5mby0+dHJhbnNf
bG9jayk7DQo+PiArDQo+PiArwqDCoMKgwqDCoMKgwqAgLyoNCj4+ICvCoMKgwqDCoMKgwqDCoMKg
ICogVGhlIHRocmVhZCBoYXMgYWxyZWFkeSByZWxlYXNlZCB0aGUgbG9ja2RlcCBtYXAgYXMgcmVh
ZGVyIA0KPj4gYWxyZWFkeSBpbg0KPj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBidHJmc19jb21taXRf
dHJhbnNhY3Rpb24oKS4NCj4+ICvCoMKgwqDCoMKgwqDCoMKgICovDQo+PiArwqDCoMKgwqDCoMKg
wqAgYnRyZnNfbWlnaHRfd2FpdF9mb3JfZXZlbnQoZnNfaW5mbywgYnRyZnNfdHJhbnNfbnVtX3dy
aXRlcnMpOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHdhaXRfZXZlbnQoY3VyX3RyYW5zLT53cml0
ZXJfd2FpdCwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGF0b21pY19yZWFk
KCZjdXJfdHJhbnMtPm51bV93cml0ZXJzKSA9PSAxKTsNCj4+IEBAIC0yMjIyLDcgKzIyMzYsNyBA
QCBpbnQgYnRyZnNfY29tbWl0X3RyYW5zYWN0aW9uKHN0cnVjdCANCj4+IGJ0cmZzX3RyYW5zX2hh
bmRsZSAqdHJhbnMpDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBidHJmc19wdXRfdHJh
bnNhY3Rpb24ocHJldl90cmFucyk7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAo
cmV0KQ0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGNsZWFudXBfdHJh
bnNhY3Rpb247DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gbG9ja2Rl
cF9yZWxlYXNlOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0gZWxzZSB7DQo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBzcGluX3VubG9jaygmZnNfaW5mby0+dHJhbnNfbG9jayk7DQo+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgfQ0KPj4gQEAgLTIyMzYsNyArMjI1MCw3IEBAIGludCBidHJmc19j
b21taXRfdHJhbnNhY3Rpb24oc3RydWN0IA0KPj4gYnRyZnNfdHJhbnNfaGFuZGxlICp0cmFucykN
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgICovDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKEJU
UkZTX0ZTX0VSUk9SKGZzX2luZm8pKSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZXQgPSAtRVJPRlM7DQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGNsZWFudXBfdHJh
bnNhY3Rpb247DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGxvY2tkZXBfcmVsZWFz
ZTsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+PiDCoMKgwqDCoMKgIH0NCj4+IEBAIC0yMjUw
LDE5ICsyMjY0LDIxIEBAIGludCBidHJmc19jb21taXRfdHJhbnNhY3Rpb24oc3RydWN0IA0KPj4g
YnRyZnNfdHJhbnNfaGFuZGxlICp0cmFucykNCj4+IMKgwqDCoMKgwqAgcmV0ID0gYnRyZnNfc3Rh
cnRfZGVsYWxsb2NfZmx1c2goZnNfaW5mbyk7DQo+PiDCoMKgwqDCoMKgIGlmIChyZXQpDQo+PiAt
wqDCoMKgwqDCoMKgwqAgZ290byBjbGVhbnVwX3RyYW5zYWN0aW9uOw0KPj4gK8KgwqDCoMKgwqDC
oMKgIGdvdG8gbG9ja2RlcF9yZWxlYXNlOw0KPj4gwqDCoMKgwqDCoCByZXQgPSBidHJmc19ydW5f
ZGVsYXllZF9pdGVtcyh0cmFucyk7DQo+PiDCoMKgwqDCoMKgIGlmIChyZXQpDQo+PiAtwqDCoMKg
wqDCoMKgwqAgZ290byBjbGVhbnVwX3RyYW5zYWN0aW9uOw0KPj4gK8KgwqDCoMKgwqDCoMKgIGdv
dG8gbG9ja2RlcF9yZWxlYXNlOw0KPj4gwqDCoMKgwqDCoCB3YWl0X2V2ZW50KGN1cl90cmFucy0+
d3JpdGVyX3dhaXQsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXh0d3JpdGVyX2NvdW50
ZXJfcmVhZChjdXJfdHJhbnMpID09IDApOw0KPj4gwqDCoMKgwqDCoCAvKiBzb21lIHBlbmRpbmcg
c3R1ZmZzIG1pZ2h0IGJlIGFkZGVkIGFmdGVyIHRoZSBwcmV2aW91cyBmbHVzaC4gKi8NCj4+IMKg
wqDCoMKgwqAgcmV0ID0gYnRyZnNfcnVuX2RlbGF5ZWRfaXRlbXModHJhbnMpOw0KPj4gLcKgwqDC
oCBpZiAocmV0KQ0KPj4gK8KgwqDCoCBpZiAocmV0KSB7DQo+PiArwqDCoMKgwqDCoMKgwqAgYnRy
ZnNfbG9ja2RlcF9yZWxlYXNlKGZzX2luZm8sIGJ0cmZzX3RyYW5zX251bV93cml0ZXJzKTsNCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGNsZWFudXBfdHJhbnNhY3Rpb247DQo+PiArwqDCoMKg
IH0NCj4gQ291bGQgdGhpcyBqdXN0IGJlIGdvdG8gbG9ja2RlcF9yZWxlYXNlOyBsaWtlIHRoZSBl
YXJsaWVyIHNpdGVzPw0KVW5mb3J0dW5hdGVseSwgdGhpcyBpcyBpbnRlbnRpb25hbCBmb3IgdGhl
IG51bV9leHR3cml0ZXJzIHdhaXQgZXZlbnQgaW4gDQp0aGUgbmV4dCBwYXRjaC4gSXQgaGFzIHRv
IGRvIHdpdGggdGhlIHBsYWNlcyB3aGVyZSB0aGUgdGhyZWFkIHJlbGVhc2VzIA0KdGhlIGxvY2tz
IGFzIHJlYWRlci4NCg0KPj4gwqDCoMKgwqDCoCBidHJmc193YWl0X2RlbGFsbG9jX2ZsdXNoKGZz
X2luZm8pOw0KPj4gQEAgLTIyODQsNiArMjMwMCwxNCBAQCBpbnQgYnRyZnNfY29tbWl0X3RyYW5z
YWN0aW9uKHN0cnVjdCANCj4+IGJ0cmZzX3RyYW5zX2hhbmRsZSAqdHJhbnMpDQo+PiDCoMKgwqDC
oMKgIGFkZF9wZW5kaW5nX3NuYXBzaG90KHRyYW5zKTsNCj4+IMKgwqDCoMKgwqAgY3VyX3RyYW5z
LT5zdGF0ZSA9IFRSQU5TX1NUQVRFX0NPTU1JVF9ET0lORzsNCj4+IMKgwqDCoMKgwqAgc3Bpbl91
bmxvY2soJmZzX2luZm8tPnRyYW5zX2xvY2spOw0KPj4gKw0KPj4gK8KgwqDCoCAvKg0KPj4gK8Kg
wqDCoMKgICogVGhlIHRocmVhZCBoYXMgc3RhcnRlZC9qb2luZWQgdGhlIHRyYW5zYWN0aW9uIHRo
dXMgaXQgaG9sZHMgDQo+PiB0aGUgbG9ja2RlcA0KPj4gK8KgwqDCoMKgICogbWFwIGFzIGEgcmVh
ZGVyLiBJdCBoYXMgdG8gcmVsZWFzZSBpdCBiZWZvcmUgYWNxdWlyaW5nIHRoZSANCj4+IGxvY2tk
ZXAgbWFwDQo+PiArwqDCoMKgwqAgKiBhcyBhIHdyaXRlci4NCj4+ICvCoMKgwqDCoCAqLw0KPj4g
K8KgwqDCoCBidHJmc19sb2NrZGVwX3JlbGVhc2UoZnNfaW5mbywgYnRyZnNfdHJhbnNfbnVtX3dy
aXRlcnMpOw0KPj4gK8KgwqDCoCBidHJmc19taWdodF93YWl0X2Zvcl9ldmVudChmc19pbmZvLCBi
dHJmc190cmFuc19udW1fd3JpdGVycyk7DQo+IA0KPiBJIGFtIHJlYWxseSB1bnN1cmUgaWYgdGhp
cyBpcyBtb3JlIHJlYWRhYmxlLCBidXQ6IHlvdSBjb3VsZCBkbyBoZXJlOg0KPiBsb2NrZGVwX3Jl
bGVhc2U6DQo+ICDCoMKgwqDCoGJ0cmZzX2xvY2tkZXBfcmVsZWFzZSguLi4pDQo+ICDCoMKgwqDC
oGlmIChyZXQpDQo+ICDCoMKgwqDCoMKgwqDCoCBnb3RvIGNsZWFudXBfdHJhbnNhY3Rpb247DQoN
CkkgYW0gbm90IHN1cmUgSSBlbnRpcmVseSB1bmRlcnN0YW5kIHRoaXMgY29tbWVudCwgYnV0IHRo
ZSBwdXJwb3NlIG9mIA0KbG9ja2RlcF9yZWxlYXNlIGlzIG5vdCB0byBjYWxsIGJ0cmZzX2xvY2tk
ZXBfcmVsZWFzZSgpIG11bHRpcGxlIHRpbWVzIGluIA0KdGhlIGVycm9yIGNvZGUgcGF0aHMgYW5k
IHRodXMgdG8ga2VlcCB0aGUgY29kZSBjbGVhbmVyLiBVbmZvcnR1bmF0ZWx5IEkgDQpjb3VsZCBu
b3QgYWRkIHRoZSBidHJmc19sb2NrZGVwX3JlbGVhc2UgaW4gdGhlIGNsZWFudXBfdHJhbnNhY3Rp
b24gbGFiZWwgDQpkdWUgdG8gd2F5IHRoZSBsb2NrcyBhcmUgcmVsZWFzZWQgaW4gdGhlIG5vcm1h
bCBjb2RlIHBhdGguIEp1bXBpbmcgYmFjayANCmZyb20gcmVsZWFzZV9sb2NrZGVwIHRvIGNsZWFu
dXBfdHJhbnNhY3Rpb24gbWlnaHQgbm90IGJlIGtlZXBpbmcgdGhlIA0KY29udHJvbCBmbG93IGlu
dGFjdCBidXQga2VlcHMgdGhlIGNvZGUgY2xlYW5lciBpbiBnZW5lcmFsLg0KPiAgwqDCoMKgwqBi
dHJmc19taWdodF93YWl0X2Zvcl9ldmVudCgpDQo+IHdoaWNoIGhhcyB0aGUgbWVyaXQgb2Yga2Vl
cGluZyB0aGUgY29udHJvbCBmbG93IHJlbGF0aXZlbHkgbGluZWFyIGZvciANCj4gY2xlYW51cCBh
dCB0aGUgZW5kLiBJIGZpbmQgdGhlIGVuZCBhIGxpdHRsZSBjb25mdXNpbmcsIHdpdGggdGhlIGxv
Y2tkZXAgDQo+IHJlbGVhc2UgYXQgdGhlIGVuZCBhbmQgdGhlbiBqdW1waW5nIGJhY2t3YXJkcyB0
byBvdGhlciBjbGVhbnVwLCBidXQgSSANCj4gY2FuJ3QgZmluZCBhIGJldHRlciB3YXkgdGhhbiB0
aGlzIHByb3Bvc2FsIHRvIHVudGFuZ2xlIGl0LCBhbmQgSSdtIG5vdA0KPiBzdXJlIGl0J3MgYmV0
dGVyLi4uDQo+IA0KPj4gwqDCoMKgwqDCoCBjbGVhbnVwX3RyYW5zYWN0aW9uKHRyYW5zLCByZXQp
Ow0KPj4gwqDCoMKgwqDCoCByZXR1cm4gcmV0Ow0KPj4gK2xvY2tkZXBfcmVsZWFzZToNCj4+ICvC
oMKgwqAgYnRyZnNfbG9ja2RlcF9yZWxlYXNlKGZzX2luZm8sIGJ0cmZzX3RyYW5zX251bV93cml0
ZXJzKTsNCj4+ICvCoMKgwqAgZ290byBjbGVhbnVwX3RyYW5zYWN0aW9uOw0KPj4gwqAgfQ0KPj4g
wqAgLyoNCg0K
