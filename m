Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6665752C5
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 18:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239370AbiGNQ3d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jul 2022 12:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237970AbiGNQ3c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jul 2022 12:29:32 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029DB6576
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 09:29:30 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26EDBdv1018911
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 09:29:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=acss5qZ2UDcDHw9xY+abHGld3VRMCPnmljqYPKubPQI=;
 b=YYOj9wazNYdmo3XfwpvgWC/2TQacKNxh2eX1LSjNi8USXsYWi5O/Q5xLDXXXSefLb4Ss
 nIHl6DvI9x0qgcBCk3DZ9uJJ8PSta4SnOm5YaluQ7DOKt2ZH+iQ1KbiMAA6N3F0I0cZw
 fyUU069eMcF9fmlM6ucK2RtAb+DJMerWH84= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3haktc1b32-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 09:29:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cG59jETdhc6ZFRCwqPIE/xltGTtGN7QMVCvA/f1sUvlT/66XwpmbaML07FTO1y/2LN9MjTvDOWVTbYy69etXJwCe7PtF41LCK9T0fRWULCcvI18ii//PL1XZY+XyHW4R/SUFGw3kTI1QoHK57mC0gEDlVmMhLNQux0bHT+xSPRcj0aNcSPW3pxG6u5PfhOyFk0M/IrfnZox1ofZot9cQ0g4G81X4zoag6GqDuiMfuZsrZbQtkP/26AywFS5hd0AHVM4uTRK2URmg5pL6YszkzqqpoLpYzBtsvwqtiybm1zpEuWEnAuzI/xujHW8tBccYR+PM0yUVDs6EjkY1JMlelQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acss5qZ2UDcDHw9xY+abHGld3VRMCPnmljqYPKubPQI=;
 b=Ju0yRk72XOansJp3+KImBFZtSnSpLGy+5316dQmh4jkKfejSJHzQeMfCS9vQdorPVFyvnVP2PYUeoHY0MkQrKwXL7rN2Z4G2yLW3pbba3sdB/ZV0yWgpKIvs9BzmDS5muocw87Ghq3/xOJ8dLbHRfcFCKsEPkPKOTP9APZQDp5EZRTPwFVvVxIcVvVOZYZUTu7OWtYHoZBFHT914e892/6GhvIzjzPp3D+AwLT4vsytcza/G4LIGpYBlkGt4ldUdaa0gdF6yHWfL7+lG3dBioxbmV4uq0jtfEhGgxoToNR+01uHXJmj0YkcXXum8Fue9yfrh0bSOhqNKPJZYm/WNsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BN8PR15MB2852.namprd15.prod.outlook.com (2603:10b6:408:8d::10)
 by MW5PR15MB5148.namprd15.prod.outlook.com (2603:10b6:303:193::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 14 Jul
 2022 16:29:26 +0000
Received: from BN8PR15MB2852.namprd15.prod.outlook.com
 ([fe80::69cb:5bc4:7861:dfef]) by BN8PR15MB2852.namprd15.prod.outlook.com
 ([fe80::69cb:5bc4:7861:dfef%7]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 16:29:26 +0000
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 1/2] btrfs: Add a lockdep model for the num_writers wait
 event
Thread-Topic: [PATCH 1/2] btrfs: Add a lockdep model for the num_writers wait
 event
Thread-Index: AQHYl4SgF3/OdzSVK0a/N8Eb6J4Y461+Dq4A
Date:   Thu, 14 Jul 2022 16:29:26 +0000
Message-ID: <2bc200b6-5135-0a9f-a824-c2d80336091b@fb.com>
References: <20220708200829.3682503-1-iangelak@fb.com>
 <20220708200829.3682503-2-iangelak@fb.com>
 <20220714132129.GN15169@twin.jikos.cz>
In-Reply-To: <20220714132129.GN15169@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76693cdf-5a72-4d61-7906-08da65b604e6
x-ms-traffictypediagnostic: MW5PR15MB5148:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CqhlTP33GLLnnumUiao9gmRCEWZjYWDKxAnUF1t6dhVVJgu/HaWJvXfWQp8Q/3JwQNfI2n2tZTCJZMLvlI9HMoHhva82dKx7AwMd0m6eIS3rZHl+7n3l4XiU5yf+gIefclp/UPLo3USdyOqUMfgYQFnA6XPUyblwhTuB35dY9KDJkKtdFL2t3cZBEscDXF4YuxfN3sYKu/3zEoCAxD9dqhBvWYL08Mv76GTkc1TblNiLzrGj8W7CReXK0QDpWZhwH9jYq6peRVGjdS1wID2m5UblD8C041X/ZrLJvPHN4C+TIwroLKL7ZLHoG9HVVS/2tFS2ZtVL1rtxs9P+G1hcxisWuzlDzLjdXgfC3qW0fB78ZHbhoSjxjw+uXYq8APO5PgB6kq837DR1FtRflihPklYroyIgw+oPahFYIM6j2tO2s4a84l6IY6l5ATfxvVzEqW3GwDxjPg8VMiFNMRW9xBtS2CIEubhnc1UtISWkEBKgnzn9qcMgb6l71lkKyIr/0sd6e0y8JfubuXhtKnESHNNCXnJC++GKAeiLhu4CEpTGtuVp+ck+5lWrAvAJl6BJQ7fdEvi3YxSRynTBjAGNZFkTUvU8vPIEPAErwNCu75Ii4CrBUdnXUcOEAjp6jmSxp1esVPmQVjbTA8VvDKDdRwGi18p8zMTIt8rfASJujqDAbKr7J8uXaHtg9FjMzXMvl4b6qgmJlvdHAhMnXv08egHt/6rVOg/tqZYHetjGaSBEXM4knqpEXTpAKH+Oc9EOPtBxearc9dne0HRwRlIJ++om3r1wB9f8CZWsYtzMvYIhjQx/ll/ER2a31OTqB+XvJIXPu2Wq/N8ViJo1hwe0XXtjN1CKqPj1AqehzCInqbA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2852.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(8936002)(66446008)(6512007)(76116006)(66476007)(186003)(2616005)(6636002)(64756008)(66556008)(6506007)(66946007)(8676002)(91956017)(53546011)(71200400001)(36756003)(41300700001)(5660300002)(478600001)(6486002)(83380400001)(31696002)(110136005)(2906002)(38070700005)(86362001)(38100700002)(122000001)(316002)(31686004)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3JqWTZha0VGd2FZeXpJNDJ0Mk01R2FiMDJCTjZyQ3VDL01qZHBxa2pkV3k4?=
 =?utf-8?B?SThIaGM3Y2d3U0JQQWFTOWhFNlZHN0FwNWQ5SWxNdmNxMTVkdXdvTWZKS3BI?=
 =?utf-8?B?Tms5c20xSmt5VEZZTEovY3VpZWxVMnNxWDNnelRRSnhucERYMzJoaDNkSnJB?=
 =?utf-8?B?TXlCSm1hME9aWDdVVUYyY3RaQ2tYN1QxMURENDJIczJiQ0gwNFhCME9ObUY4?=
 =?utf-8?B?dmgzckxlR09UczZ2cEpoMmpMWGZ5czhLb1h0WklHemg2NDFOMUNUTUo3N0Js?=
 =?utf-8?B?RUw2akQxVksxc25qeUt6d2JuNlovd1psT3hzLzRWUmRLRmx6djg1VVBhaTdW?=
 =?utf-8?B?QlNsbjd5M044aXdySXlvc1Z0eW5jaWtlS0FQNWMyVFFuaXRnZVBhTGdOa0Fo?=
 =?utf-8?B?MmxoQXZkV2t6YVNQUkNtZW9DM3ZyRFUyQVBRblg4U295bzl0dkZTQ1kwdnVO?=
 =?utf-8?B?WitDcVFjUytrMlJzaEdYYTczSjQycjlHTzNVa0h1eUo0bFQ3V01kMlF4OHlp?=
 =?utf-8?B?cG9Obnd6SHVzZ1l2eHRCMDhsVGFEYm94aTY3NUd5c2xTd2t4WTZqYzc2YktP?=
 =?utf-8?B?MnM5ZFV3NjYzaVUrQU1nU053cWVGQnNJeFhIeHlINmgwM2F2Mk5pVzRRNlZi?=
 =?utf-8?B?QmFQYkNCSWRremplc2pXUTM5MjBVL0R5eXNXc20zdTAwSzFkaE9RWlFtWU50?=
 =?utf-8?B?STgrUFQwd0MzOVZOdmQySmIycnJPeVZ3Z0ljU1doajJSODZ4c3NUS2NnWUVw?=
 =?utf-8?B?M0h5UmtBZU5xZVRLNVNZWnRrbE04QU4yMjdCM3BlbzhxVkFUZUxEcGlINVA5?=
 =?utf-8?B?QjhHNHI5RUNsQWUxYXNBcy9KLzcyWmFKc01JZTFkbnBYQmM5a3dpQ09RSkZO?=
 =?utf-8?B?UG5MVEFiUGl4NzhacFpFaUxJdk13elBmSllrNGdWODdVL2J0REJXZ3lJVjdR?=
 =?utf-8?B?WnhFay9QbjNIMnFGSGFNc0hidHl1WDZuSnFrVmJrNmhzRWxsd21iUkFiUThT?=
 =?utf-8?B?TGFQMm0xbzFiUDZQWXBkcVdMNTIyTGVBaDZZdU9Td1NNZkUzenRqd0ZBRFJz?=
 =?utf-8?B?SkwxYkR4aUVaaGlCdkhEbUZGL0MwWmFuMkZabFNsd05FM3FlZjdVTVkwcDVm?=
 =?utf-8?B?cTFZYWhEcVhEL1JKNmYxYVExUzVwSDFFUnQxTDI1Ti82U0pkZzhhOW1EWFUz?=
 =?utf-8?B?MDk3UTJ0UFhuMU9UTEJNOFY4OEoycmd4MWt2aXdjN1FKSEVleWFmcUZJcVBB?=
 =?utf-8?B?OVBjdHRCa3Zrck5vVjM4TVJDNXNDMVowMmVqZG5JVHJtR2hsRFpEVlFDZndT?=
 =?utf-8?B?TTUySUlZejJDelFxR2tIUFdHSnZnYm1RTzdmSmtMWjZjMnE2UGNQeG5nY1Jq?=
 =?utf-8?B?akljNUVYaHRyNmVucldFc2RKUjJvYktIV2xFNVNIQmFXQXNTQ3YrdENqZGtX?=
 =?utf-8?B?cngvUTdYLzNkTmJvTm5FcG9qZ0FWa0dNVXQxNW1ZWTVtL28zT01OWHA0Mjhj?=
 =?utf-8?B?R3Noa3dRUUdUZXVURTd2UXJsVzZuU0NRcklkQ1Y3a3BxQjJPR3kvSFpRMEFY?=
 =?utf-8?B?akpEUWtjVjFvMHVPTFE4TkpDaWxIc0ppL3lraGJoa1ZhQ2lZVlZVMmh4WjNn?=
 =?utf-8?B?MmR5N2FBZUtLNiswRnZsMkk3ZGFFWmxtMDhKUlBOQVVPTEdXZmd0aDVKM1JX?=
 =?utf-8?B?YVFZd2tkbG11ZXI1TFg0cSszdFZRM2k2TENmSytxVDFSRnljM2ZKTU5kL01i?=
 =?utf-8?B?ejN6a1R3U1BWS1dxZzE0aDRONVBoR05IdjJWT2xNemZ3RWdTOGI1QWh0ZGtm?=
 =?utf-8?B?OEROYnNMTEpqNnF2MVk5T0dycjNpaUthSVBNUkwxN0ZzdmFUWjYwMnJva2hr?=
 =?utf-8?B?bGZBWVN3c0JrYjMrRzBvMll4SFBQMVpVU0RqSlFHS3hNc0tOWWFiSjhkT1Nz?=
 =?utf-8?B?anhWemZqL3F6Z3IvUzAvQUpHbXYzZEFCaHhWYTkxZ2RLQ2E1WVZFN0YveEt4?=
 =?utf-8?B?d3drdHhNV25OQjlQQ2lSTHY0UDVWbmFkWGlPYmlzZGdTTVM2TEZtR0tJa2hY?=
 =?utf-8?B?MWJYUjFsUG9na0ZEODlZejlKeGcrRVpyUXFBb0RWa2RzcTVGN0xHTGtPYlVT?=
 =?utf-8?Q?Z2gn4AmWyLnq18LtkuKFbJOwJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF122FDF467CA24D9BE7DE558A74A1CF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB2852.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76693cdf-5a72-4d61-7906-08da65b604e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 16:29:26.6856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aiiSalGDFxf0a9VLLkS/vYxMgWTQ0sZ/fZEclHeCLCL9zBzBPKumB00KeyE/JFsT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5148
X-Proofpoint-GUID: 7W1uNDXAAIrllNpiVtnuRXYfajvUYlWp
X-Proofpoint-ORIG-GUID: 7W1uNDXAAIrllNpiVtnuRXYfajvUYlWp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_13,2022-07-14_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gNy8xNC8yMiA2OjIxIEFNLCBEYXZpZCBTdGVyYmEgd3JvdGU6DQo+IE9uIEZyaSwgSnVsIDA4
LCAyMDIyIGF0IDAxOjA4OjMwUE0gLTA3MDAsIElvYW5uaXMgQW5nZWxha29wb3Vsb3Mgd3JvdGU6
DQo+PiBAQCAtMjIwNyw4ICsyMjIxLDEwIEBAIGludCBidHJmc19jb21taXRfdHJhbnNhY3Rpb24o
c3RydWN0IGJ0cmZzX3RyYW5zX2hhbmRsZSAqdHJhbnMpDQo+PiAgIAkJCXJldCA9IFJFQURfT05D
RShwcmV2X3RyYW5zLT5hYm9ydGVkKTsNCj4+ICAgDQo+PiAgIAkJCWJ0cmZzX3B1dF90cmFuc2Fj
dGlvbihwcmV2X3RyYW5zKTsNCj4+IC0JCQlpZiAocmV0KQ0KPj4gKwkJCWlmIChyZXQpIHsNCj4+
ICsJCQkJYnRyZnNfbG9ja2RlcF9yZWxlYXNlKGZzX2luZm8sIGJ0cmZzX3RyYW5zX251bV93cml0
ZXJzKTsNCj4+ICAgCQkJCWdvdG8gY2xlYW51cF90cmFuc2FjdGlvbjsNCj4gDQo+IFBsZWFzZSBt
b3ZlIHRoZSBjYWxsIGJ0cmZzX2xvY2tkZXBfcmVsZWFzZSB0byB0aGUgY2xlYW51cCBibG9jayBi
ZWZvcmUNCj4gdGhlIGNsZWFudXBfdHJhbnNhY3Rpb24gbGFiZWwgc28gaXQncyBub3QgcmVwZWF0
ZWQgZXZlcnl3aGVyZS4NCj4NClVuZm9ydHVuYXRlbHksIEkgY2Fubm90IGRvIHRoaXMgd2l0aCB0
aGUgY29kZSBhcyBpdCBpcy4gSWYgdGhlIGNvbW1pdCANCnRocmVhZCByZWxlYXNlcyB0aGUgYnRy
ZnNfbnVtX3dyaXRlcnMgbG9jayBhcyByZWFkZXIgYmVmb3JlIHRoZSANCndhaXRfZXZlbnQgYW5k
IHRoZW4ganVtcHMgdG8gZWl0aGVyIHVubG9ja19yZWxvYyBvciBzY3J1Yl9jb250aW51ZSANCmxh
YmVscyBsYXRlciBpbiB0aGUgZXhlY3V0aW9uLCBpdCB3aWxsIHRyeSB0byByZWxlYXNlIHRoZSBs
b2NrIGFnYWluIGluIA0KY2xlYW51cF90cmFuc2FjdGlvbiByZXN1bHRpbmcgaW4gYSBkb3VibGUg
cmVsZWFzZS4NCj4+ICsJCQlidHJmc19sb2NrZGVwX3JlbGVhc2UoZnNfaW5mbywgYnRyZnNfdHJh
bnNfbnVtX3dyaXRlcnMpOw0KPj4gICAJCQlnb3RvIGNsZWFudXBfdHJhbnNhY3Rpb247DQo+IA0K
Pj4gKwkJYnRyZnNfbG9ja2RlcF9yZWxlYXNlKGZzX2luZm8sIGJ0cmZzX3RyYW5zX251bV93cml0
ZXJzKTsNCj4+ICAgCQlnb3RvIGNsZWFudXBfdHJhbnNhY3Rpb247DQo+IA0KPj4gKwkJYnRyZnNf
bG9ja2RlcF9yZWxlYXNlKGZzX2luZm8sIGJ0cmZzX3RyYW5zX251bV93cml0ZXJzKTsNCj4+ICAg
CQlnb3RvIGNsZWFudXBfdHJhbnNhY3Rpb247DQo+IA0KPj4gKwkJYnRyZnNfbG9ja2RlcF9yZWxl
YXNlKGZzX2luZm8sIGJ0cmZzX3RyYW5zX251bV93cml0ZXJzKTsNCj4+ICAgCQlnb3RvIGNsZWFu
dXBfdHJhbnNhY3Rpb247DQoNCg==
