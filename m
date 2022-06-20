Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5F45525E2
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 22:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344236AbiFTUiD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jun 2022 16:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240838AbiFTUiC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jun 2022 16:38:02 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D6D632D
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 13:38:01 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25KIwv1f003998
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 13:38:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=XVAamdRCh11QTc9WP3zvRb6PGixx0tvm3zz6Ganvxr0=;
 b=mHdNzVgTafJ7H5QhdPbam29XaS0vEIyWSbwcQfca35e+kvhbh0enATpUymvRdVV4Y9SQ
 U56JudlzeeZol6SW8W3C/YGqu+M5qQgGSW4bNkshgPcI28EjoqgxwAIgZfFr9SXlEilw
 IO77j2SqyH4IBr8qJ+ZJVvmzIgGa1XK7AdQ= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gttynj8xh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 13:38:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/8zGWGByqi8LcqJqFU/ShG0OfzH6d5ThFBUOq8yPTbja/2o2E7U1qBZOrTnmvc67hQw4nPHNz9IzuXJ1DXS3sAUXvuzokBR3qOQ7QrzLcF9Uz1K9V7jI/Z4PbbiCNdydXpdCfUcPslx8HkRwMik+ASHnSQS4LL8GpyezmTRYT+sJ0DgD/gLbj/8S3A6/XVwq3rlQVcYD7mB9ZLPr4vdRgOrZe/udD5nbBQ1nUzM48xUnxzD9AKueKwwbeQ3wMSIC6cnqAkXVX2FxL2Jnh9kGA84uIfiUxpJLEpzm0fEOx97CFEFYr6DPwkG9wQSEX5wUVrTf7+JCAUWchQd5fH9/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVAamdRCh11QTc9WP3zvRb6PGixx0tvm3zz6Ganvxr0=;
 b=ML7s+EPUAhpbSseWWKAn3m0FlzPBG8VgxftaIDjRESHsquEMrSZKO3OW6IHtLlru4hurXPK1Ixtda9MHNkMGL/Dc8fDkFH1fL4fdKiosKJj7B/+z/V7yfzYZnmSoraAiFyfZCnwU6R9SURN68oCojX1wRSIVvUkcC/sWK5ESdCt9or8gaCKG9Mi/Tf8bz+PwbQaMwI9KqccHuPVo16GLF3/m2p+O5Bkl0iM57dXc4da8tsGl9CPVcOKwqbeYJ36kUNft6/o5UzG7hV0ODD74dduHqqGbtEkusWiB1PQpcmQkFFPlQaBjxRKYtzoFKSJJSyA+yjE9IkA5H0Wd0feWnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MN2PR15MB2863.namprd15.prod.outlook.com (2603:10b6:208:ef::33)
 by SA0PR15MB3967.namprd15.prod.outlook.com (2603:10b6:806:8c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Mon, 20 Jun
 2022 20:37:57 +0000
Received: from MN2PR15MB2863.namprd15.prod.outlook.com
 ([fe80::4963:5880:383d:8018]) by MN2PR15MB2863.namprd15.prod.outlook.com
 ([fe80::4963:5880:383d:8018%5]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 20:37:57 +0000
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     Boris Burkov <boris@bur.io>, Nikolay Borisov <nborisov@suse.com>
CC:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v2 2/2] btrfs: Expose the BTRFS commit stats through sysfs
Thread-Topic: [PATCH v2 2/2] btrfs: Expose the BTRFS commit stats through
 sysfs
Thread-Index: AQHYgLYkpWlVkINpoUGWzpQtk3opna1QdwUAgACGeQCAASuHgIAAGMwAgAaIAQA=
Date:   Mon, 20 Jun 2022 20:37:57 +0000
Message-ID: <e080497a-604e-e537-34d0-fc24bd443f80@fb.com>
References: <20220614222231.2582876-1-iangelak@fb.com>
 <20220614222231.2582876-3-iangelak@fb.com>
 <916ea0a3-d3a0-6c60-1307-7873438286e3@suse.com>
 <20220615133130.GY20633@twin.jikos.cz> <YqpQANRnbc4uBmjT@zen>
 <8020b3cf-ea57-fe85-1784-630e83bd558a@suse.com> <YqtgEIABdQkWw0hQ@zen>
In-Reply-To: <YqtgEIABdQkWw0hQ@zen>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14abbdf7-4070-4a8d-780a-08da52fcc25d
x-ms-traffictypediagnostic: SA0PR15MB3967:EE_
x-microsoft-antispam-prvs: <SA0PR15MB3967E874308485C53835493AB3B09@SA0PR15MB3967.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RFYpkzoGHAIYWNFA+h/tJQSrSf+id3FAio/FBFOdCKHIEJSjjLK2pXi335qDIVRa+6Hb4LOWs8UZS32StBlbjphdXvXiqFaF51iZcC241LB3eIB96bwUCjNoPouJyoIgO2QHI/KkjA7MjgR2xiOCV1kPjgiHu2nj8+vv6s6E+x5OHy0wdp19MPXdyI0q1IDZLJzqUP/h09c+splZlslUxSC0MVwgG+/uH12LM3ackqTolkScpephE0tdQTA4HChlOclxN6wlpScqU7NCxaY3nZdaTavCkqEbDAfbJUBi67lkbVHrdAJxpP+wyKuhYq0A3brqSLluyf+9mHXy8Ae+qk/nAX78MfQIOxsuTylT5jSW9PwzB3/1CgyUV+lphhjIac4CbLebCB5PT6vN5+RyTUGD14bN39XvFUCFHvVzYB+OQqA4b8ZiK96sIPFFhAA/PZAIoKycz2uR+vtfR19uk2izB6Manmv+mVvgL7PLsHWpaPNuhGkz4EY9uJfRJ43IksHYtscKKz6AW2Qj8MhX7No6BYybvTmtBYcsMy443qVI3W4cUmZr80rPq5Gag7JcWr/8Hf0FhWb+T/hGEr0l/JJie8FNsb2DNTjIIYVzukorBkwtcdZYchFEkG1pwv0TzfU/CI+CbSbngPyR83axI2dcdlYOznUheVnpX4EEWHmeidR5DgmaC9nch9EErsGpZR95zrjGp1R9/GMOWh9L8o6LMssD17H92CNB8fXH/v4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB2863.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(36756003)(38070700005)(31686004)(122000001)(6506007)(45080400002)(38100700002)(110136005)(54906003)(316002)(66556008)(6512007)(4326008)(186003)(2906002)(64756008)(76116006)(66476007)(66446008)(8676002)(6486002)(91956017)(66946007)(8936002)(478600001)(2616005)(86362001)(83380400001)(53546011)(31696002)(41300700001)(71200400001)(5660300002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0R2RHpZa1NzclVHdjc4SnNMeFNxemJWcDNQNy8rMWpNUHlVLzFLcHBCTlF4?=
 =?utf-8?B?dnNqa1RYQTFGS3BQVXo3WHhqdW81Qy9teS80YW5vSmt2czhmV3JndzY0Y1ZB?=
 =?utf-8?B?ZTgvZlUzSEZxZ0FOZkRBK2pCTFR5Y0h2VDJzVkNTSUpXbjRiVjdtTWcxT2NL?=
 =?utf-8?B?a0RRejU1ZWRmN3VCQ2l2Y0hmNGRCRzNUMGRiSnJqUTAyekVtYiswN3RkU2l1?=
 =?utf-8?B?NGR3WEFmdnMrZzd3TXYxM2hsSU9zUFgvY3dLL0EybmhzaERyNHdndGdGbDgr?=
 =?utf-8?B?ZGJHR1Nzd3pocHVvcDlkbkYyRnVrVGhTTGZqekcwMG1NT3Q3MG9FY1NEMjhY?=
 =?utf-8?B?MjJnTWhjcnpyeXAwSGVtaE1iajhtT0tNa0hqWFBSREFjS2dXSkZZc2xGL1lX?=
 =?utf-8?B?UFQ4SElHWXk2NUU4OVIrbTg4SVJudlA0Y2d1UjV1cE9USjM3dkE4RlhKS01N?=
 =?utf-8?B?cnRFNE5FUjliaUprYXJ0ODRGVnJHaE9jZDVqSUgwQS9iZjBsWjE2U1VQR2JO?=
 =?utf-8?B?L1drN1ZneldIUURsejVPeUJueWdrZ01Hd284ZllOdmlXcDAwZ0t3ZFNnaWZY?=
 =?utf-8?B?emhBa096QUs2RHpaYW1zc3pyOGRsdGJNeTZ1QWU1bjJaUmRFS0xFRElWanhN?=
 =?utf-8?B?dEpoNkRBY09zK2tYQTJpRmo5TFQzenp1Nk5aTXQ3OHMxSERwdnNHYTR1T0dC?=
 =?utf-8?B?ZUh0aWxCSzFMWW9zRHlKNVdkU2dvbDRoNGtXWGY0Nmo1UHRxMGJBSlZ1WWpN?=
 =?utf-8?B?cTVEdE5xRW1HL1ltRjhKRXdVblpLRW54TkdkYXcyRTI4WVh4Q2w1WGNCK1o5?=
 =?utf-8?B?RzF6WUtQQ2FQLzcvcTBXWUh5cXJueFM2OTEwcTlhdzVVdmpHL1FJK1lVek9E?=
 =?utf-8?B?eEVjdmtYYVVHTDJGLzVZUGQvMmNsOFIveFZJOWpWUWpWOWdZMHVUWkdydE5U?=
 =?utf-8?B?alhQc0wrVHA2NVczMlBwUENzcHI5anZQYXdDNWJPSDJxL0h4d1ZuQ012cXky?=
 =?utf-8?B?bTFmVzhTZ2RFUzBvTi83Y0h5TS9GQXU5MiswRkl2L1p4WkViR2tiTFJZem9q?=
 =?utf-8?B?c0pOZS96VFdKVUJDL3NObHlNaW52b3RSODUvbFJwWmRyVGNNMTYya3FCNlRC?=
 =?utf-8?B?OTY2UjA5dVMzRW9NTlZ2WnMrRGJ4M0UzRTBic2JxZExTemtZeDE1V09HNzht?=
 =?utf-8?B?OW9BY25MNXBWZjVXMWcxTU9uTEZnSFhLT2FKbjhLQXI2QlpTSkhWR25NQWtq?=
 =?utf-8?B?cVE2WDczNzhhQWw4bXpXQVVORlZtZVpEUnRZOER5QnRVeGJZdmNyaUN4VTZS?=
 =?utf-8?B?cG1Odk5mYVZrbmFONVFESWtyQ3h4eDY5akNWdXU4NmpGSGtnQmMyR1pray9o?=
 =?utf-8?B?bEZYNEE5aWxWK1NubmcwMFdQYlhvb1F3Szk2ZUpNcHZmbFNFZU5MbFkxZk52?=
 =?utf-8?B?ckMvS0pJSEppNmVIVnRZejFYcjlWMk5oQTg2TFEzbFFaQWtkM3p5eTRzakVE?=
 =?utf-8?B?T1B4NEVFeVYwMDM0NG4zckNldjQwZDdCY3ZMRUtaVHVtdVhuNXJhbi9RQjEz?=
 =?utf-8?B?VDlocmcxSUF1N2tBcTltVW9YSkNWVUIxa2o4b1hhT09jdTlDdVhyVTMyNm9m?=
 =?utf-8?B?NURJNVZrMytUSERXMzhDNnpTdlJocHowQ2YzWFFvZmc5dlV2Rk5BNkJyVlZr?=
 =?utf-8?B?MitJUklBb2NLRVZsbUhvRDgxcEluTnNkSUxldFU3eVVYWWdiOUI1alk2aEJt?=
 =?utf-8?B?QURGZS9CS0N4ZWlWUFBROFdiR05YTzVYQ0NQQlZPQTJzVy9XVlpKZVI3SGJO?=
 =?utf-8?B?QnJUaWdobTZyTlliT0YwYTFOT2JuaUNoSGtMYXkzc0JqZ29FNVAvZGFJbktx?=
 =?utf-8?B?MTdyVHBVMnE5b3F5NExmSFlBalI4eHhIVlhPcFUzR2w2cDBlQU0raVAyckRX?=
 =?utf-8?B?d2tJOWRtSWxFRVJDeDBUZUcyWnd3cGlCL3FiSzJ1b3pudTNvbDBpY1JJZzZz?=
 =?utf-8?B?blBDU1hHdGVlaWx6aG5wcDE1Mm1XSittYkZVZC80V2VlMVNNd3pmUllraTZj?=
 =?utf-8?B?VXpnZ2YrVThsS2dSNVZPNmJIWUpCamVETmZFQjUrMGdlM3VWV0VpZlVXSFpw?=
 =?utf-8?B?eVRKR211YVdzdm04KythQTNUcG1SSVA3UEZ4ZHJhcG1ET0M1UWVpakJnMVdk?=
 =?utf-8?B?Z3FvNTNoYTlJVnFnU2ZtU3BzTDFsazVPbHRXcFVuSldqVktRZlhmRElOOFJC?=
 =?utf-8?B?anRCYkJwZ2tqM0FBRGJXL0JmTkRrck9MWlBocEdlMzhJdU1qd0hTTnJVWmJr?=
 =?utf-8?B?dEdIdlkzRkpYMG8vSW90cm1ZdVF6YUhLNldsWnhnbkdxMmp1bVFEUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E66C9A1AAD87247B69194175F424BCB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB2863.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14abbdf7-4070-4a8d-780a-08da52fcc25d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 20:37:57.2019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wtRhUsEnsfOORDA5Frny0L5LLAm3zKP/CYOz2kbLopqAtwNaBfyOGY0g37peS10I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3967
X-Proofpoint-GUID: JbF2jHx_9yG5-HVXepD1WLq1anVwBX6b
X-Proofpoint-ORIG-GUID: JbF2jHx_9yG5-HVXepD1WLq1anVwBX6b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-20_05,2022-06-17_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gNi8xNi8yMiA5OjUzIEFNLCBCb3JpcyBCdXJrb3Ygd3JvdGU6DQo+IE9uIFRodSwgSnVuIDE2
LCAyMDIyIGF0IDA2OjI0OjUxUE0gKzAzMDAsIE5pa29sYXkgQm9yaXNvdiB3cm90ZToNCj4+DQo+
Pg0KPj4gT24gMTYuMDYuMjIg0LMuIDA6MzIg0YcuLCBCb3JpcyBCdXJrb3Ygd3JvdGU6DQo+Pj4g
T24gV2VkLCBKdW4gMTUsIDIwMjIgYXQgMDM6MzE6MzBQTSArMDIwMCwgRGF2aWQgU3RlcmJhIHdy
b3RlOg0KPj4+PiBPbiBXZWQsIEp1biAxNSwgMjAyMiBhdCAwMzo0Nzo1MVBNICswMzAwLCBOaWtv
bGF5IEJvcmlzb3Ygd3JvdGU6DQo+Pj4+Pj4gKw0KPj4+Pj4+ICsJcmV0dXJuIHN5c2ZzX2VtaXQo
YnVmLA0KPj4+Pj4+ICsJCSJjb21taXRzICVsbHVcbiINCj4+Pj4+PiArCQkibGFzdF9jb21taXRf
ZHVyICVsbHUgbXNcbiINCj4+Pj4+PiArCQkibWF4X2NvbW1pdF9kdXIgJWxsdSBtc1xuIg0KPj4+
Pj4+ICsJCSJ0b3RhbF9jb21taXRfZHVyICVsbHUgbXNcbiIsDQo+Pj4+Pj4gKwkJZnNfaW5mby0+
Y29tbWl0X3N0YXRzLmNvbW1pdF9jb3VudGVyLA0KPj4+Pj4+ICsJCWZzX2luZm8tPmNvbW1pdF9z
dGF0cy5sYXN0X2NvbW1pdF9kdXIgLyBOU0VDX1BFUl9NU0VDLA0KPj4+Pj4+ICsJCWZzX2luZm8t
PmNvbW1pdF9zdGF0cy5tYXhfY29tbWl0X2R1ciAvIE5TRUNfUEVSX01TRUMsDQo+Pj4+Pj4gKwkJ
ZnNfaW5mby0+Y29tbWl0X3N0YXRzLnRvdGFsX2NvbW1pdF9kdXIgLyBOU0VDX1BFUl9NU0VDKTsN
Cj4+Pj4+PiArfQ0KPj4+Pj4+ICsNCj4+Pj4+PiArc3RhdGljIHNzaXplX3QgYnRyZnNfY29tbWl0
X3N0YXRzX3N0b3JlKHN0cnVjdCBrb2JqZWN0ICprb2JqLA0KPj4+Pj4+ICsJCQkJCQlzdHJ1Y3Qg
a29ial9hdHRyaWJ1dGUgKmEsDQo+Pj4+Pj4gKwkJCQkJCWNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90
IGxlbikNCj4+Pj4+PiArew0KPj4+Pj4NCj4+Pj4+IElzIHRoZXJlIHJlYWxseSB2YWx1ZSBpbiBi
ZWluZyBhYmxlIHRvIHplcm8gb3V0IHRoZSBjdXJyZW50IHN0YXRzPw0KPj4+Pg0KPj4+PiBJIHRo
aW5rIGl0IG1ha2VzIHNlbnNlIGZvciB0aGUgbWF4IGNvbW1pdCB0aW1lLCBvbmUgbWlnaHQgd2Fu
dCB0byB0cmFjaw0KPj4+PiB0aGF0IGZvciBzb21lIHdvcmtsb2FkIGFuZCB0aGVuIHJlc2V0LiBG
b3IgdGhlIG90aGVyIGl0IGNhbiBnbyBib3RoDQo+Pj4+IHdheXMsIGVnLiBhIG1vbml0b3Jpbmcg
dG9vbCBzYXZlcyB0aGUgc3RhdHMgY29tcGxldGVseSBhbmQgcmVzZXRzIHRoZW0uDQo+Pj4+IE9U
T0ggbG9uZyB0ZXJtIHN0YXRzIHdvdWxkIGJlIGxvc3QgaW4gY2FzZSB0aGVyZSdzIG1vcmUgdGhh
biBvbmUNCj4+Pj4gYXBwbGljYXRpb24gcmVhZGluZyBpdC4NCj4+Pg0KPj4+IEFzIGZhciBhcyBJ
IGNhbiBzZWUsIG91ciBvcHRpb25zIGFyZSByb3VnaGx5Og0KPj4+IDEuIHNlcGFyYXRlIGZpbGVz
IHBlciBzdGF0LCBvbmx5IG1heCBmaWxlIGhhcyBjbGVhcg0KPj4+IDIuIGNsZWFyIG9ubHkgbWF4
IHdoZW4gY2xlYXJpbmcgdGhlIGpvaW50IGZpbGUNCj4+PiAzLiBjbGVhciBldmVyeXRoaW5nIGlu
IHRoZSBqb2ludCBmaWxlIChjdXJyZW50IHBhdGNoKQ0KPj4+IDQuIGNsZWFyIGJpdG1hcCB0byBj
b250cm9sIHdoaWNoIGZpZWxkcyB0byBjbGVhcg0KPj4+DQo+Pj4gMSBzZWVtcyB0aGUgY2xlYXJl
c3QsIGJ1dCBpcyBzb3J0IG9mIG1lc3N5IGluIHRlcm1zIG9mIHNwYW1taW5nIGxvdHMgb2YNCj4+
PiBmaWxlcy4gVGhlcmUgY2FuIGJlIGEgIjFiIiB2YXJpYW50IHdoaWNoIGlzIG9uZSBmaWxlIHdp
dGgNCj4+PiBjb3VudC90b3RhbC9sYXN0IGFuZCBhIHNlY29uZCBmaWxlIHdpdGggbWF4IChyYXRo
ZXIgdGhhbiBvbmUgZWFjaCBmb3IgYWxsDQo+Pj4gZm91cikuIDIgaXMgYSBiaXQgd2VpcmQsIGp1
c3QgZHVlIHRvIGFzeW1tZXRyeS4gVGhlICJtdWx0aXBsZSBzZXBhcmF0ZQ0KPj4+IGNsZWFyZXJz
IiBwcm9ibGVtIERhdmUgY2FtZSB1cCB3aXRoIHNlZW1zICBzZXJpb3VzIGZvciAzOiBpdCBtZWFu
cyBpZiBJDQo+Pj4gd2FudCB0byBjbGVhciBtYXggYW5kIHlvdSB3YW50IHRvIGNsZWFyIHRvdGFs
LCB3ZSBtaWdodCBtYWtlIGVhY2ggb3RoZXINCj4+PiBsb3NlIGRhdGEuIDQgd291bGQgd29yayBh
cm91bmQgdGhhdCwgYnV0IGlzIGFuIHVudHVpdGl2ZSBpbnRlcmZhY2UuDQo+Pj4NCj4+PiBPbmUg
b3RoZXIgcmVhc29uIGNsZWFyaW5nIHRvdGFsIGNvdWxkIGJlIGdvb2QgaXMgaWYgd2UgYXJlIGNv
dW50aW5nIGluDQo+Pj4gbmFub3NlY29uZHMsIG92ZXJmbG93IGJlY29tZXMgYSBub24tdHJpdmlh
bCByaXNrLiBGb3IgdGhpcyByZWFzb24sIEkNCj4+PiB0aGluayBJIHZvdGUgZm9yIDEgKHNlcGFy
YXRlIGZpbGVzKSwgYnV0IDIgKG9ubHkgY2xlYXIgbWF4IGluIGEgc2luZ2xlDQo+Pj4gZmlsZSkg
c2VlbXMgbGlrZSBhIGRlY2VudCBjb21wcm9taXNlLiA0IGZlZWxzIG92ZXJlbmdpbmVlcmVkLCBi
dXQgaXMNCj4+PiBraW5kIG9mIGEgc291cGVkLXVwIHZlcnNpb24gb2YgMi4NCj4+DQo+Pg0KPj4g
SSBkb24ndCBrbm93IHdoeSBidXQgSSBsaWtlIDIsIGV2ZW4gdGhvdWdoIHdoZW4gSSB0aGluayBt
b3JlIGFib3V0IGl0IGl0DQo+PiBpbmRlZWQgaW50cm9kdWNlcyBzb21ld2hhdCBub24tdHJpdmlh
bCBhc3ltbWV0cnkuIEJ1dCBnaXZlbiB0aGF0IHN5c2ZzDQo+PiBpbnRlcmZhY2VzIGFyZW4ndCBj
b25zaWRlcmVkIEFCSSB3ZSBjYW4gZ2V0IGl0IHdyb25nIHRoZSBmaXJzdCB0aW1lIGFuZCB3ZQ0K
Pj4gd29uJ3QgaGF2ZSB0byBib3RoZXIgdG8gc3VwcG9ydCB1bnRpbCB0aGUgZW5kIG9mIHRpbWVz
Lg0KPj4NCj4+IEEgZGlmZmVyZW50IFBPViB3b3VsZCBiZSB0aGF0IHRob3NlIHN0YXRzIHdvdWxk
IG1vc3RseSBiZSB1c2VmdWwgd2hlbiBkb2luZw0KPj4gbWVhc3VyZW1lbnRzIG9mIGEgcGFydGlj
dWxhciB3b3JrbG9hZCBhbmQgaW4gdGhvc2UgY2FzZXMgeW91IGNhbiByZXNldCB0aGUNCj4+IHN0
YXRzIGJ5IHJlbW91bnRpbmcgdGhlIGZzLCBubyA/IEZyb20gYSBtb25pdG9yaW5nIFBPViBJJ2Qg
ZXhwZWN0IHRoYXQgdGhlDQo+PiBtb3N0IGludGVyZXN0aW5nIHN0YXRzIHdvdWxkIGJlIGxhc3Rf
Y29tbWl0X2R1ciBhcyB5b3UgY2FuIHJlYWQgaXQgZXZlcnkgeA0KPj4gc2Vjb25kcywgcGxvdCBp
dCBhbmQgc2VlIGhvdyB0cmFuc2FjdGlvbiBsYXRlbmN5IHZhcmllcyBvdmVyIHRpbWUuIEZyb20g
c3VjaA0KPiANCj4gTXkgMmM6IFdoYXQncyBtb3N0IHVzZWZ1bCBmb3IgbW9uaXRvcmluZyBhcmUg
dG90YWwrY291bnQgYW5kIG1heC4NCj4gDQo+IFlvdSBoYXZlIGEgcHJvY2VzcyBwZXJpb2RpY2Fs
bHkgcmVhZCB0aGUgdG90YWwvY291bnQgYW5kIGdldCBhbiBhdmVyYWdlDQo+IG92ZXIgdGhlIGNv
bGxlY3Rpb24gaW50ZXJ2YWwsIGFuZCBpdCByZWFkcy9jbGVhcnMgdGhlIG1heCB0byB0cmFjayB0
aGUNCj4gbWF4IG92ZXIgdGhlIGNvbGxlY3Rpb24gaW50ZXJ2YWwuIEZyb20gdGhlcmUgaXQgc2Vu
ZHMgd2hhdCBpdCBoYXMNCj4gY29sbGVjdGVkIG9mZiB0byBzb21lIERCIHRvIGJlIHN0b3JlZC9w
bG90dGVkL2FnZ3JlZ2F0ZWQvd2hhdGV2ZXIuDQo+IA0KPiBPdXIgY29sbGVjdGlvbiBpbnRlcnZh
bCBpcyB0eXBpY2FsbHkgNjBzLiBJIGltYWdpbmUgaWYgeW91IGNvbGxlY3RlZA0KPiBtb3JlIGZy
ZXF1ZW50bHksIHlvdXIgaWRlYSBvZiB0cmFja2luZyBsYXN0IGR1cmF0aW9uIHdvdWxkIHdvcmsg
YSBsb3QNCj4gYmV0dGVyIHRoYW4gaW4gb3VyIHNldHVwLg0KPiANCj4gV2l0aCBhbGwgdGhhdCBz
YWlkLCBJIHRoaW5rIEkgYWdyZWUgdGhhdCAyIGlzIHRoZSBiZXN0IGludGVyZmFjZS4gSQ0KPiB0
aGluayBpdCBhbHNvIGxldHMgdXMgZ2V0IHJpZCBvZiB0aGUgbG9jaywgc2luY2UgeW91IG5vIGxv
bmdlciBjYXJlDQo+IGFib3V0IHJhY2luZyBzZXR0aW5nIHRoZSBtYXggd2l0aCBjbGVhcmluZyBp
dCwgc2luY2UgaXQgaXMgYWx3YXlzDQo+IHNlbGYtY29uc2lzdGVudC4NCg0KSnVzdCB0byBtYWtl
IHN1cmUsIGRvIHdlIHByb2NlZWQgd2l0aCBvcHRpb24gMj8gVGhhdCBpcywgY2xlYXJpbmcgb25s
eSANCnRoZSBtYXggYW5kIGdldHRpbmcgcmlkIG9mIHRoZSBsb2NrPw0KDQo+PiBzdGF0cyB5b3Ug
Y2FuIGRlcml2ZSBhIG1heCB2YWx1ZSwgcHJvYmFibHkgbm90IFRIRSBtYXgsIGJ1dCBpdCBzaG91
bGQgYmUNCj4+IHdpdGhpbiB0aGUgYmFsbHBhcmsuIFRvdGFsX2NvbW1pdCBhbmQgY29tbWl0X2Nv
dW50ZXIgLSB5ZWFoLCBJIGR1bm5vIGFib3V0DQo+PiB0aG9zZS4NCg0K
