Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F005A60F06A
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 08:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbiJ0Gi2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 02:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbiJ0GiZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 02:38:25 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC6F1645E5;
        Wed, 26 Oct 2022 23:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666852705; x=1698388705;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=XC/oXH8pTqcp9V3TxDwNdSqDpFMDLUZI4ysogzPANwQJNQJzF2WsnLup
   jbqvUt35+jxXhT+iJcb29zI1sPgmfq8BwaAJi+KuNn9V5u6J1cqBoQdg+
   lms9YHvJOpkfVqHRDeq9LigTdJ9YYY5py6UYWG/l2CWE3PQ8RTHHZ+n01
   fO8FEFbgqMweYz0JmMGMm0t7Ey3haYlwF06IbYRVr0RvYuHNTh3c9Ye1L
   RNvQzyemLrEZurzEcQI2ESlFgTA8/O9T3kvhFIuIR0kFfPxiFkksu+0C9
   zQU3bISY4F7AsukphDf5d5rAaSEWAIe1TrgAY/KCIVp66TbmEss8M9+V7
   A==;
X-IronPort-AV: E=Sophos;i="5.95,215,1661788800"; 
   d="scan'208";a="214848271"
Received: from mail-bn1nam07lp2045.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.45])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 14:38:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmVwfs1j997D1Z9RkibbcslguBbIXzgx5AJR1PU3GiXhnQStBvu3NiBLJGBXDKpkEFmn9jR0zYBt03G8+bhOpS8H60UPdpzSoRCjp6PXClkUP1w8oxNGqVeG0vb4Z0FSl080VGC+KfN7ZnKCozD2FoysfEEnh26FXfJkykLSvu+PuIMLuFCDvBRewUV++t7aO5SCcI/KsKv5Dy6oKjcYYcA3LmQH0Ij0dmAsK+irknG3YICOcSmTnktoEov4jG1H5/Wr0Cz8RKRHfy0MipbKaNtxNfvtpUybu/x0Mb9bqqztU95NV67OCBP8t2gCyuvttr6/bDc4IzshDVBTCL5yUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=eTpe56kLQ3YSbCpMqwQtWZiXOiWUHF06CMGSXTWZ7lzqgiU31p8kwwHfTZj6XS4J3eWNolWptt+PdabiDnSOIk3C8FRtBYpB1Pi/Qi/QYhOi1b7YK2ch+l0MLS3a2sQ4jF/lMXKkSUBF3r14yATqa6yUssE4q9PUZyh2WzNWqj1VJMdCXl9kByjUhIuK8mtDnpOvRFQtydCkBLIgb1WueuaAoTn95Xo5KD9UlB6NuhenQgeEsqP0ktdeJliBzRhVLosbUreAtzcxPFd7MrKWQ8obG9qfmCxno/mQawJEyfjxOd3WRrDiH6pD8YlFGDzooK7DDA74RawfjBtsYtq7EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=M7fbCIW+bl9DjVIUViXZlqlSAuM0YR6LxFKHHS0ysLO4aQTkCKug7CXox8jXCC5OGk2Nq4mtTQot75HpnmZosv5kLpLQ6zJtKPOjKtv3qqeCFfTV6B2TiV087gZ5TuoSfQlvKk1bwQfYTdijhuw6Ebm9+w5/uBYAvq/0WBp/qdE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR04MB0509.namprd04.prod.outlook.com (2603:10b6:3:a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 06:38:22 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5723.041; Thu, 27 Oct 2022
 06:38:22 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Yang Li <yang.lee@linux.alibaba.com>, "clm@fb.com" <clm@fb.com>
CC:     "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next 3/3] btrfs: Remove duplicated include in
 delayed-inode.c
Thread-Topic: [PATCH -next 3/3] btrfs: Remove duplicated include in
 delayed-inode.c
Thread-Index: AQHY6ccwZUinQfbsRUmn/QbUbsc3S64hydqA
Date:   Thu, 27 Oct 2022 06:38:22 +0000
Message-ID: <17578f3c-b529-6869-8db3-2ace8a6fb2ee@wdc.com>
References: <20221027054343.9709-1-yang.lee@linux.alibaba.com>
 <20221027054343.9709-3-yang.lee@linux.alibaba.com>
In-Reply-To: <20221027054343.9709-3-yang.lee@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM5PR04MB0509:EE_
x-ms-office365-filtering-correlation-id: 783b875c-5665-40e7-d028-08dab7e5d7f4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: euK7//xx1HqvaRbJR8FoLb+y7YlO/OmcRb/MMnV/Qm4BwEITtvUxx+192HkmvYKEyU1PiuG80np5efPuHzl+DS4INMq05wFBWW9bLvV2nJpx4ljh7lv6ghkt9n2AVzTzab2T4hiM7YXzeBE3bMLdzVwO8jey+6rm0xDv2SrrMsRr/yy1NE4vmCPh1KsztsjgPuvWz1IkhFQX2rWb4xT480/kB7ME/Jmh/oAKK4bz47PHas8av3j71VRDMukc1rL6CTh0eBU+fRDXmwu3RBzsOhWEef5NRKd2OHbgWqaCkyTZKQIRrmjbIEMWNi0TsMQqMN+sPEjpahny3ct1dnSPdg2aU3aSmEvFaqFOOJ8IoWQeeG2cimQU4EneX3xiQyKjGdRm4Sn5rjCkniIdNwCbgv29za2Bzd6/N7mc6NNNjMj/LHojQigeJCEHMX2F8rsgf1QsZu2+k/vg1gEKvIhQwv+SbPDhFWDORq40Q7johRloiPsPbLPcOT90xQ6RA4qVxdojI72tIJ/LapupX8uIFKtiLIu4pyQZYfV+EFqbK9nVwbVQCYZFTPGAQt5dsnwiNNthGHvNKT5qkdS7Yb4dgQ7pan8rK7kG6weLIjyyNC6erA09OaFv7pWkn/T7pUiH4hFAvzTGWHpVhCxuFLlXXwM4iUNAIIEtFqjCIi1V1GmdrzxprN1W5FxuSZQjJmLPYCJZKHtfc32ByRNQ1IZC757HzX16JG2+G7bpCWmcD7PPCUKB+3lCGE7T83mgFvijx5/sH58YUR6UiEcd9YHfMukpy0pK/39NZDKpkTSFctNv6/3RmKEv7pCZiIPsiUOGd+KZ10G+Ml/sSaAa8dnF8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199015)(54906003)(5660300002)(558084003)(478600001)(8936002)(110136005)(2906002)(6486002)(38070700005)(4326008)(38100700002)(41300700001)(71200400001)(66946007)(122000001)(66556008)(19618925003)(36756003)(76116006)(8676002)(66446008)(64756008)(66476007)(4270600006)(91956017)(186003)(6512007)(316002)(31686004)(2616005)(31696002)(82960400001)(86362001)(26005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TktHZ00yOVdYTWs1WmJyUElFMFpUZzF1OU1BMURMTlBuU204aXA5bTFwWERw?=
 =?utf-8?B?N1VjL01KdXJCdXFCZkxURW82ZEhHVzNNSzhGczZtUkRUTjRDVjVaTjVZTUFB?=
 =?utf-8?B?aGZDNUYzSTQxQm8yaEkwblUrRlFJdTRoNjZJRnVrc1YxcUN0TkFkNHRiN0JS?=
 =?utf-8?B?WkJqZjA1MTdQVzRpVTVKVEFNT1RTcTFqQTEzZE9wbk5kZCtjQ0VTU1NNTnpi?=
 =?utf-8?B?ZS9UVDllK0lnM3VpamUwQ0VFODBjRlJXT3dOT0d2RXN0VDBjaHg5R3JSYWkx?=
 =?utf-8?B?QnVhWHV6ZlJjeHFEZktlTkxWQ2RDdExtekJESG9ldDU0dnNncHYrcGQrQ0ht?=
 =?utf-8?B?ZW05WVZtUUZnVzVJUlRlODRGQkxUamF2Y0xNNGcvZG8rTmFYOEl3d1k4dUtB?=
 =?utf-8?B?UWZzMElvMk9tM2src0I0TE5WbGk0M3dsRDFrdW40Ky9WWHNWcU1NcnBBaG44?=
 =?utf-8?B?UGc3dkIyYlhKN2txckdmaWlFeHlkblZid29IN0FUamNJTnMrZzAzaGEvMU5r?=
 =?utf-8?B?SnJxTkFyMEY1cmlqNDdNU2I2Z1VZZ1NUQWkzVm1TSjJFWWlLSEhoR0o4NGZ6?=
 =?utf-8?B?QlBRYklQNkZEQWp5VWs4UHoxemhSbnY3b0QrOFQxVzVTRFFWNzBrekJ1WDND?=
 =?utf-8?B?YW1EeXhCWDBGZFdzdm83REZtWU1mQm9xd2k1YWlmYTZ5ZTMrbUY0QUhqemM1?=
 =?utf-8?B?M2djVWVqSmpFVFZnbysxT2w4a2djYnZiSnZ3UVdVayszYm0zYTJtd2lDVzJE?=
 =?utf-8?B?K2d4d2I3TktuTnVJekF6RUlvWkdPdVlPajJYZjgxTVhVV21XU29NemNxM0Vi?=
 =?utf-8?B?ZTk4OFdya0VZZnY5QW8zWWxCSlFNSUk1T2x0V0J5Z2tWb3ZoMS80aXlOaFVX?=
 =?utf-8?B?N3dzZTRnUXEzeVgzUnlhNTFYUEF6b0hzZjFBTHhvNnRPSzZPYTJWcmZUWmpS?=
 =?utf-8?B?bFllUFdzTnBXbWR3TlQxaTdLeUNiai9qdFJ4RjNBM1FCNmg1VTRDcVJST1ds?=
 =?utf-8?B?cWlSQmpKM2NaY3RTaEVlakc0TUMvaDIweVBzVDZLTHVzZkMreXhGbU5BeUZy?=
 =?utf-8?B?K3dsSVIrRWREY1F4YzArYUtJMG0rSXhFYmVwSnpGaDNCV2doYlY2eDNjN2x6?=
 =?utf-8?B?U0s5a0p5Rmk0cTE4NzZUbFFBTmJiREFWcFZZZGxLOENHK08xSVMyMFEyVkJh?=
 =?utf-8?B?ZGlaQWhHTHZmaW5yTG9EZEUveDVYK1pIeXhaMjk1ZTJRTkNrd1FGTVFwRWFm?=
 =?utf-8?B?ODVYL05ycy9xSXJmVE5sQUlpMVErRGd1VDFxZWJiUFVON243TkNtVzNnQ0Iv?=
 =?utf-8?B?UEdxTlMzUFVOSi9ESkdza3dFNWViK1VkcUdhWjRycnYwSjE1VEpJa1Z6OEpp?=
 =?utf-8?B?cXFpZWxZNUZmcFZSZTVUQ3UvSzhSSHA2TnRFaThHY0xXdmpMTm85NWVEOXdh?=
 =?utf-8?B?TGxBc3FjQm1tNEp0RHc1eHNKbTlKRVRvMWJZdUtuQ1N6NkR5TVI1RG5iZUhr?=
 =?utf-8?B?N2dENE4wY3pSUWJVbzBKaDFGbHBUVTJoUUJEYmpIWUdrZXJPV3BqUVBpWlpl?=
 =?utf-8?B?djlSRk9ORzZqZ2h6N0RpRWwyUnRSVjFjOWk1eEkrNGwveGdrYXk3c0c5c1NL?=
 =?utf-8?B?b2h2NG5xWHkwZmNUdnJPdTV6MGFjMGIycHVEa2FOVG9XNUF6bFI4ZzRFUkt3?=
 =?utf-8?B?Z3ZwY0FaVGowYXpJTlNPNXBubDhRZTRsTmliQzVQWmJPeFNhSU0zM28zeENZ?=
 =?utf-8?B?dmo4QktjNnVsSjVTOHJxc1ZYVzRoeGZTNjJIMXZYY3E2M0FrblRIK1E1SHVQ?=
 =?utf-8?B?NDY5ZTNMMHVMR1Q0dDhtUUh1QzBqcmcrakt1TUpKUzNPa1dCZnAyZlljUk53?=
 =?utf-8?B?TGc4Umc4UmdrNi9NUzYwMmlWOXFvTm1ZbHJ5c2lETzRXR3N3S3hEakxPUFAy?=
 =?utf-8?B?VDM0c09hcllCSlBoTnZPZmkzbFh1SkdZeHl6eE0vOVFMemZGLzBCS1ZRdWZa?=
 =?utf-8?B?a1NJenBRRnBYc3pHcDdPcGx3a1Z5UVlHNEFaNkIranYzRDhQYmV4eGtibDBJ?=
 =?utf-8?B?NUpZV1diaXRScXdXUEF6TDJ0czRMZ0Y5ci9xRDNDVUJUUnFjNnVjQkJodlhs?=
 =?utf-8?B?aFdRZG9aYjVFQ1N6dVdmUXQyUkVVU2N0UFlhRGllV1pUUHE4eERzU25OUHhT?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4419BE2404D0E04082493997858BE525@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783b875c-5665-40e7-d028-08dab7e5d7f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 06:38:22.4729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ahJDfIsh+lrPdbYuHimH3/uZtNr81yXNb2kd67LnkKcA93hNmEbUpAbjsCeWRjqR29r+h7BK56aTjSX73CPTF+C2WFxF84a/xMUTSidY8FQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0509
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
