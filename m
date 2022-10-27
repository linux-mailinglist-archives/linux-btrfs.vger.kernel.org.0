Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1733C60F475
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 12:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbiJ0KIZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 06:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbiJ0KIW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 06:08:22 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CC5108DFF
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 03:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666865301; x=1698401301;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=ahtGmvRYmBCMnUDFXJB4MS0jNntNXtiDIXOrl7JaCPXSoKTK6QLCeL24
   Skxa1gyvdTuk9cDT+87cU8mzlxkzKxrxAHTIR1i7qOwpOwC/9YCVu1/lu
   PN7pMwVjAXy2Ah4/jPcVf7ucJ5Uxz+JHl4pXa0jjRP9HvaGJdL8VSdWjk
   O4JITLwTdWJk5wCHgziKNfhY+qzaDfToQnTVgRbhVNLPc7vmvt0CmhXrm
   6OcwMqdc7v2Afyy6Cg/05PTudIlgt7NvJhPcaMASQmUgyVrW9a3cEHxb+
   w5KrYUHUvNIVTmpkqppU+WVFVVwzQIvKjlJoy/mAmeyx7SX8O4WHfToTu
   A==;
X-IronPort-AV: E=Sophos;i="5.95,217,1661788800"; 
   d="scan'208";a="213161423"
Received: from mail-bn8nam04lp2041.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.41])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 18:08:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVU8IOQMlWAwXLPRmXs2VQ8SDMvkQTTaILLksOMXQMBQTRXMwuehrxz6YPm1ore8HocpuNW6tT7/+pagl377xYJhgBFXQre9wIi+haiyeE5qjmFGWl82qAZ+0XOmPDpVTLGpkkeAI/8RxhqM/4qkDvhXSx9w+Qjr6GgCFvS2dhU6ux8H2OWYQ559GpXKJEi9cmLO7ukg/DEze9SssC/T+teo1vdkgrX2+P1QVnVe2RRv4T96vW5Zwn5Jx0kVq1fxqN6SsAtod7KVRtup5uEM0MroZBk2aVvrSWyntRZwyC/6F5nTpSmmbtkjg3Ysam1hvaZpjWTq/dGzdm1vUgYQ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=FR17jdJsNnE4f0JatX+Expp02zbgyka9FBzcYvABwHrQQpf5WPd1HmheP/uvLkbeR4KYnzOQ5yY/rgX5Qe5xRLHIHSr4gS+sJhCZorOYrKcqIjU5PoBunTyx7VAjKlp0kW1HYtyFJkyDdzNYY3lvF9PGXYhoUCeZLZZtuhLdd4q9T6hQkV8HZMPISwUbsfvy1GvtIciy5AoyPAG/hScyKniV9BMwC16dlRqYYx2PTVVmNQvJNp9aX18WEcm+hdCnUodKjNaPdVB1oLmKKUoIyGQd54CrgJSCAFsBWQEa7kf/M0QENXlq8v6md8QGYqEVDHOVWunlUsKL/7f/7Nv5jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Qcf/M31NOK0iwTitq/KbL3VYS7GK91Y12jbnviNjS00KKqEQUiJPDybYOgMr8Dv++QL/A0GyFC7Q4oudHP2w1ckbAL13fY2j9GuZjwcQqjBLubN/9c9IE4Q6GRWEmqaLV08vQFscOMHy3a/fr1Q0qJeBng3lBBiocYMb/xx5Llc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB5758.namprd04.prod.outlook.com (2603:10b6:208:a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 10:08:18 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5723.041; Thu, 27 Oct 2022
 10:08:18 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 16/26] btrfs: move the 32bit warn defines into messages.h
Thread-Topic: [PATCH 16/26] btrfs: move the 32bit warn defines into messages.h
Thread-Index: AQHY6W7Z/0JmwCI61Ey23sQyPFjgga4iBTOA
Date:   Thu, 27 Oct 2022 10:08:18 +0000
Message-ID: <e95601e6-3529-b3ce-892d-98f05323eb48@wdc.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
 <17591700d3d77aa81c2e32d3e010c44782e257fa.1666811039.git.josef@toxicpanda.com>
In-Reply-To: <17591700d3d77aa81c2e32d3e010c44782e257fa.1666811039.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB5758:EE_
x-ms-office365-filtering-correlation-id: de963569-d746-4d7a-58ae-08dab8032bdb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K77Qwhc43bu1SZkgsviHHB+0eWHIGrFlBbD2bxhxisfzp9dnXnG+wM3grmioRU9VsQRJ1ZSYJ/rDSj73RaPEpq7391fi8HVKIkFB74WAIN2boFjB9KCMnrwb9zFG6Z9HG0OGL2O7KbYfUSdpeHmPWJpTILMTptFIHaZ5SbowSaBB56vX0TT1lmaSHzo3oBphUyRXEtIydOkJ8PdVK0yU025d+Jt6f6yMUSvdYENSfrJ9k1zs1TXKthJlnBrvCkYB794/rUdGJqN2DMW8KXJm4+VBg/cB5V6nWQvUcKmNw8wogD86NAUKcwjDHGyTwX9/2/KleVeHDVgSdyDzJ4Pg9UKh5QyoYPj2EbRE1pJT+k/erT2ddKDAUJVhwD5Vvpe3+pkzQAit0zwf0Dg0erB7WICjesDSRSP6SDFINW9cDhiXjvQG0IbLZfam1gON7vGKY3ttRwwJsJD+3HcKU+fGFerF8sXTrYxeSU50ZngQBRx4feiVbWHjuR10l6rq/E9buQI3qFBKH9UgPlN9hRWibPIGaD3odQ0aZeqq5uSv3xHLghUbbi11rwIjpRhLe6kW3rw3uCFvZAuexpR+Lnb3HSYtY5jIwBzA403cH9q2pLpY+zumzFJ/lQFv01AXbIVB3XOvE4sEYYgNQtfPpsGoT/JVP9VtLp6UAlvGy+qSFClvcFjVD57j0PdopuGJJAV9ofFCRq8OjC6AQHEF9WFf1C1+wvsRXSJro1NTqp0mvVEYrRC/LKxcdtyQOlVKWZOindGNBgi2grtHP+NxOJCeudm4SrnLtQbMY0NwrnA+XbGCMWvVCp9Tpbzo3s91F8EAMkaGyw7+LulG+gKCtGZ+0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199015)(41300700001)(122000001)(64756008)(8676002)(38100700002)(71200400001)(558084003)(110136005)(8936002)(66946007)(66556008)(2616005)(66476007)(91956017)(82960400001)(26005)(4270600006)(186003)(31696002)(5660300002)(6506007)(6512007)(478600001)(6486002)(316002)(38070700005)(86362001)(66446008)(36756003)(19618925003)(31686004)(76116006)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVhYZkZqQnNIZlY3bENLOWU1TGdvYlk1YUxpQmYwVnJsajQyZFg0aGVtYU5L?=
 =?utf-8?B?c0xxcEQ4QXhHWXhyMmxGdFhtZGZaQTdRdUlHRE1LSWdJYVpOUDgyeDY5SjB6?=
 =?utf-8?B?eXo2VmZVak5kN3ozdkVLeU5BT0VGcW5sTlg3Q0tDNEZEazl2elJqM2x2RDVI?=
 =?utf-8?B?RktmTVcyelZkai9EcENxTHczcGNPY3hJK2gxbGMrR2VjckN5Mis3TGJnQ3B2?=
 =?utf-8?B?MVltYkI5b0NNNjdjaTFwcXc2N1FMdXgwRTdHWEV0T2pWb3R1Z3FobHdVS2U4?=
 =?utf-8?B?bG1DSzJuYS9WaEJMTW85UFBpa1A4SXUvaVFyNlFzWUpDclo1UkxGVllmQmQr?=
 =?utf-8?B?YWtiUTN2NElXanhSZktZd1JYSFJ0RTlTNEk0Uy9UcitJRWJ4QVI4UkdURkVs?=
 =?utf-8?B?Q09WNytJR2h0VjFCT1VBWHVRRnRGZHEvUnJMMG1FVXAyQ1ViWmFnZCs3UjFn?=
 =?utf-8?B?dEwvL2lCTnVQWnJSSXZvUEkwcCtiemhvbU51Z0Fpd0ZVMG80MENiMnVCYkor?=
 =?utf-8?B?dWR5Uko2TEo0ODNvN1lPdGVxdkRLZ01lWVhIWEQybThob0dVV0FZOCs4Unl5?=
 =?utf-8?B?VVo5N1VMMERBK2tRa0pIb29WZzk3UnJNNUIrUnZmcWEwTnc2ZTdldFJWNnpP?=
 =?utf-8?B?YXFuVDVNL0IyTUIzWHFEZkYzaFdZZFU3dmNWTUtZODkwNnBqYTR6SHhwUmp5?=
 =?utf-8?B?Y0dQWU92YVRBL2JSQk5oU2JCQmltNXpQU24zemhMZUd1TllTcnVicGY4QVpq?=
 =?utf-8?B?Q3FJV21haU9aMWIvcWJ4dC9uRFBWenFDajRuZjJydFRDUWhwaXZRMEJKTkJi?=
 =?utf-8?B?cmIrM0Z6b1p3ZUNUU3ByUCtXdWEyNC9ZMjlTL2oxU2RUY0FvSS91R0dnaVk0?=
 =?utf-8?B?UXZ2ZVdyQ1RZaFgzd2JweWRmMnUxaVRIUVNEMmMxYzgycTE1NmV1UXVCd0Vj?=
 =?utf-8?B?VklmcjVaWVArdFRmRk5uNFRNM0N6KzdITS9Mb1FlZFluWGNSb2U0ZzRJOHl6?=
 =?utf-8?B?YzUra244QitZQkZBemZlUUpGL0V6UDBYaUJsbFlQeVgzN1Z1a3IxN1BGanhl?=
 =?utf-8?B?VnlFZHg5UFNxb2U3V3F6K0dvUXZxTkJhT2U3TlR5dEc1bDVJVEN0MWE2QWN6?=
 =?utf-8?B?cE1jNXo5dGpqR09iZFlKTlkwemtnRTNuZW5LSmhEczVYTmxPaUN4NndSamov?=
 =?utf-8?B?RVRDS2Nwa1I2MURqTWsrajZuRjhSVnQ2MXpnZlNkZjhGY21qNUdOSWNTYTRn?=
 =?utf-8?B?TlRscWQwVG44RittTER1SENQMTBsRkZnTDVXTmdwbVRRWlNYSmJBTmxCcDBT?=
 =?utf-8?B?Z1ZkcUgvZVN6UzA5UlBiVk91US9WTmQrN05CYzFEQldvaUNOTnEyWEVaaUgz?=
 =?utf-8?B?OW15Mjh5YlVjQmVXcGJneXRSSC9kVm5JN3NWcmJ2Uml3T1l3SWs2UzVxTVRM?=
 =?utf-8?B?ZjNNS0pzZS83ZnpqZmNETzFHVVBJZkdZYytYdGdFcnRHUS9YMkU0M2FjWlVj?=
 =?utf-8?B?MnBzZVE0eHI1V1lXWU9ua2VKQTFaUWhibHM1eDZPc0VHMFIyeWdLREtlazl5?=
 =?utf-8?B?WmpRWEFIay9QeGczVHNnajhkbEM3dDAzczhzR2RaT0VFeC9wWkt3d0Rpb1JS?=
 =?utf-8?B?UGhvc2dJMmlKWFIvb05USUE3NmhscmJTQzYvNXdsdlU2S1RIdHowUGlPaW5k?=
 =?utf-8?B?MFI2cHZUYnlzQmR4ZXA5U2ZNMXlGN2FGS1Z1SG1zaUoxU1JLYXNjcVpLSkN1?=
 =?utf-8?B?Ky93UWRpeXQ1Wk0ydjAvQW5tRmR1VDc3b0doMklWK2wrMFBoZGRpM0YrNUFV?=
 =?utf-8?B?L01scHpua2FSL0lubkNvemxobk1tZ3dRZHduWmJtSGYzUTVvWEtSVk9Fckhw?=
 =?utf-8?B?QlRJckNIRExYSE1FYmtlOVhKeTkvNWZBUEpwM3NXSnZiaHFqTGp3Y0xnNFdL?=
 =?utf-8?B?MXBBdVRoMEUxQ3EzMmwrZGtTZmVKNHRGUUprREVHNWJiUE1lVEthS09KWFlG?=
 =?utf-8?B?MkNVQlN4WklRS3dGbVJmMHRjSXUvY0RldHBmcXZKdE0rZ2lxVkI3TllReFZ0?=
 =?utf-8?B?Z0UxNWppMFJwM0tXWUh0a2xtanpCNU5paURnMUxOOU81ZjF5WFZZMDUxcGNB?=
 =?utf-8?B?eWI5NVhmZlY2VjdGdVZ5VXFramhqOGZjT2R1SGROYlBXOUEyVmZrdTRGc09Q?=
 =?utf-8?Q?cxtk4m3CGM4TdvJiPTC2SY0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EE659E100BA6247ADDE0875BD691B63@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de963569-d746-4d7a-58ae-08dab8032bdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 10:08:18.5929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P5O/tHMhzjWCkUgDgSqBUIukIzP7NLIGOSyd9jvV1hGk8hBGf4E+TFzRtXB2dnF8HLH/W3GSgrUCs0Z0REo8D+VtwVUHw6gtjLOWJm4rWvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5758
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
