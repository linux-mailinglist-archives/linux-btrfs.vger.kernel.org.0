Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31946B2919
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 16:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjCIPtO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 10:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjCIPtC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 10:49:02 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF82113F0
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 07:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678376938; x=1709912938;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=WoK/0fS9sIjM8Bbk4ElIZ+H/X4cIN9wHYPb9jg4O9Dc=;
  b=oFeYRdwr4ewafzkUyBkxLBza7OsgeX9jVpZkrYxjqffIu5B3BrAwRDWH
   vbck7ZFr2ucUItU1aQ5TlRcPjjCk+tlQEyQkCqQY9sR5oKF+uZO5LvXB4
   +BdVd/L37joRxesieMlpjeVTJFrSTEJEksOg06DP0ryyeLFYao03yZKbk
   xKi1IgFTUkwR8A1/KJOygEpieo/jgYg99dk3zKZjS3qo6F329Pbyd1zFp
   5QyfrZfuiJ47OyeRGG/Sto6RjUU3tfc6ECetBNWIa1V6rEo8ZrbafljYY
   23LoNtOJfHz1YPjUYqiI7BdVur/mDT2UUQ4vcOfsaZvlznhNOkPBeSng4
   w==;
X-IronPort-AV: E=Sophos;i="5.98,246,1673884800"; 
   d="scan'208";a="329596369"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2023 23:48:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuLRKzyL13fTIomkkPccpssWU/8qzuH5sJsJbqSM0WIc8Y+HuzdD13OcXaGkR0uls5ZKpKRVI5j1nox7NCvvyOtAwko93DQpu4/VIXliLHI+YGkhOO61i4CMQWRJ9wb2bM40o1junx1PW7kt8iV+ox2EcsheWHu1GctMxjqmpnmo/LxiFNQUvTcVcDd5JbwxOSwbtEfhz75+8DK2gTK4upleJr6VzKmLuFzdBWtklD3WHHps9RPRFF0azrYq9LDmWl3x25r/i1EPdy2rJ+DhH1dFeox4ECyDOA5B2AQz62n1hjyxfOAg7pCpF0ITRc0kXaUz+Q4Pf/RDXvElIQRiCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoK/0fS9sIjM8Bbk4ElIZ+H/X4cIN9wHYPb9jg4O9Dc=;
 b=Q1LAq47Xhgpp/i8sCFr15oN22N9CNB1+B+DI4doTieu17rKLrqrPlXR27mQxtbpCrw20dXxTIr1WD2SWSiVKfxu0DaiZy6a40yWQ8MCiYML372l5pcdoGjKnX2R5GmcPlhmrWx2h00I3kpJ29I8VLZ5ZF17BEidgbhCxfXWQvZdOFCF2tN5rupf/rwbSVotEG9O4LwTTiHChLE+NUuYtFOQ70F4pHZtORCWB8p6DbvcUGJa8O10GA+daMnmCx0Z+LdUE+i8KRD4s7GuYGqe8auHYFnLjkvtg0rPFVT/TTNvUmbXouJJ+wrxSlM1F1lLJkw5ZB4fvQmY9ZIYqwF4z2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoK/0fS9sIjM8Bbk4ElIZ+H/X4cIN9wHYPb9jg4O9Dc=;
 b=sN4ODEfxuCt6gVglLSyG01r//H1c7jpRZBS/uvSI/iildfuFz7e9c2LXpY6mG1Tc6pM4WkyWSSlIv0HKczeUJwC4HkEpSyM/siGN6SVXyX0P1ZXs9SgnwWojqEkPO7Hk8nBQXs7ucUofhvH5D5QQ0V5Do/y5FKQQLv5wclX6VFE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR04MB1016.namprd04.prod.outlook.com (2603:10b6:910:55::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Thu, 9 Mar
 2023 15:48:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 15:48:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] btrfs-progs: allow zoned RAID
Thread-Topic: [PATCH v2 6/6] btrfs-progs: allow zoned RAID
Thread-Index: AQHZQUosDMpl+3pj50aDHiPnO2nBa67xxmEAgAD0IQA=
Date:   Thu, 9 Mar 2023 15:48:09 +0000
Message-ID: <dfffe31c-5af4-0552-21d4-36efa0f968a3@wdc.com>
References: <20230215143109.2721722-1-johannes.thumshirn@wdc.com>
 <20230215143109.2721722-7-johannes.thumshirn@wdc.com>
 <39fd6b09-5a47-abb5-bc5b-f53c78dbbfcc@oracle.com>
In-Reply-To: <39fd6b09-5a47-abb5-bc5b-f53c78dbbfcc@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CY4PR04MB1016:EE_
x-ms-office365-filtering-correlation-id: bf3caf1b-5de2-47f9-c3a6-08db20b5aead
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r26iZqx2Oe9bQql8fve6JZ263ut2r1GpaROWsxa7fpw+dxsHn7XSd9Rtd2cD1empK5kwjOPgwZHDZMEOZeLCmcW7WO87VAJPgp/lhX6kRbyCksmOOSqpa4JOWwWIJYbEcs+rMngK3NuVnuC+2/OcR7M/JGPnubHh6UGe8g/FLnrZLXLGlcad0dYpCv/j4J2bqP2UgyyY+LjbVqBniKpo+neR3CidRcnOwuZJ2NKJ35xT88dJhzCtqCyagUFZ2LrjQ6FAlhBmPntx1ZUdSSQ8EbBNU87HrTGbWNsVlqWLHYBK6EVsw1Ep1ECtBflAfmiqa6EOd0xxWtS/IeYAmrqzViC4zalxuq+qknk0OW5HBp8/v/DSBjCAMFE9iofdAnN8tMMHAXMbik2+x7X/IN/FieK9casMwsPVjLx4nPKd3XUofsZg6kkaWT63bpyaeNk1Oa7x4Ngk9Ui+ltDlWI57d3HDqAIZOT3EwQlZpBMzIpcZeVbBQK01VWJqW3sbPFflJXyFHwmiyPOtokhNLRgguDfUyz+Sdw1Bqd3d8di+4KpWhoa865e8UQLcszT1UpE1fP79QMpPv6uQ5NmCoD30ZKea1SO9ov4XqB03eX8pr7npOYyS59RcWT2QmiabZhgR/uMTji1SvKG9/pztcb6vjYPYk9eIdfHIDYULuKY8b1RZcSFsPnvxwE46tcNznJeKGAp4/yasA6Iix1zWae0kNCkD7Cyqzu8hciq+oJD3osUg5d01x6dshsEfnQPrjjMz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199018)(38070700005)(71200400001)(110136005)(31696002)(41300700001)(83380400001)(36756003)(86362001)(8676002)(66946007)(5660300002)(6486002)(66446008)(66556008)(478600001)(66476007)(76116006)(64756008)(8936002)(91956017)(186003)(82960400001)(2906002)(38100700002)(31686004)(316002)(2616005)(6506007)(122000001)(6512007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWhaNXBzcU9zWUJKVVpqQjZ4eWFOb3BtK3hKM3g3L3VkQ1BKYzFoS0NYT3Fn?=
 =?utf-8?B?Y2EyYmFWU2U2U0dySWFPRjYwNmYwN2liOEtJR0daOGdNTTFDN3NXcFpMUERJ?=
 =?utf-8?B?NFJDV3luWCtBR3BtdGdvMnYyOTJ5SVZ2RG5NVEx6R2pGOGJwOHFsaE5wVDQ4?=
 =?utf-8?B?Tkt2a1p3VkZ1VDkxOEZHT2FBL20yakdQaXgwQWNTMG1qSk5Za2Q4Si9ZNFNh?=
 =?utf-8?B?VU53b0NidDZxNit3RXpDOXIzalY5dU5aMlRMRDNXQ24zWlBFSHIwM3BtQ1hC?=
 =?utf-8?B?VmZWMEVXdjNSb3ZGTTR5d1NUOUZTbzU2di9MemtsMVhaSFhteVprUGszaW95?=
 =?utf-8?B?UDBFZk5nd0RtK2lvK0tvbS8wcmNxc2VFdFJkVGlrczJWWFBWSE5BVmFadTdW?=
 =?utf-8?B?RWpnOGM2ZGdINzFFdEhCMlZyM01ZMmdQeTlydXJMZkV0UDhXMjR4bWZna0V4?=
 =?utf-8?B?Wk9RRDlndFd6RU56elI0QTJDbFY2TC8zN0lITm5RcS9Sa3gwVzhSNUU1b0JX?=
 =?utf-8?B?RHNNVVBWczRjOU1Va3hTOTh4dlRTVGJMT2VSS1pjd3RHZFZ2Y0RzMkFhZXdD?=
 =?utf-8?B?YTZ3SVYzMm9XMkZMdS9MMU5tUXFpRkxzb3MvbUh3M3BMN0ZxbDBnU3pXYVM5?=
 =?utf-8?B?bDNRS1U1QVI4blFLY2xNTzlVMW5SdVdmMWY5MVpBWEx4TEhWVXZDdkJ6Q1c5?=
 =?utf-8?B?Qy9mTXptajYyaExMQnh0cUZYQU1SdVRJd0ZUb2x5MSt0WDNnMzU2b1cvQ0l6?=
 =?utf-8?B?MzB2c2o1YVYwS1ZVcnVlcVpHUjFPV2pkcStKSm1oSGJWelFlUTBGeGI1aUN4?=
 =?utf-8?B?eEk5cnFVdzA2ZFBFclF0L1NLWlNLNlJndGsrMFBLUWVQTURWWnhRRHJWL2Rq?=
 =?utf-8?B?WWpldmNkalhuTElCWk5UajZ6QnU0UWI0enQ4STdHVWsxS1kwV0diVnpMMmdH?=
 =?utf-8?B?T1VOWVYrSlREYXVENGpQTlRYUGFWak9QSGZuQmdtdEgwRFlBRHdnU3NtTEtO?=
 =?utf-8?B?c0pJQUFGcnRtY0h6c2dCQmNNSzBra01IczlvM3dHOGxjU3Q5Sk1rbVFMWVVQ?=
 =?utf-8?B?cU1kZkI3YUtOQU9KV0JmOUVwZjdvQ3QzeFJGNEdxcXhqbTRHN0R2dUQxa3cw?=
 =?utf-8?B?bSs4V1hOblBFNE9aekpuY0Irc2JMK28vVFErK2t1QStteFFXSEFwdFZNN2R6?=
 =?utf-8?B?enRpYUNPUzd4N05ML2xjSEM2RFIyd0pibDVnQk0wZUgzdWI3cXFvdm1WRkZl?=
 =?utf-8?B?TU9TUmYya3FlWnRJVUN1QjlRRkc1clA1cWNFRXdHTEhJdjZDL3lNRHFEdDd6?=
 =?utf-8?B?VUhudFJFMkJkRzdxZXFwWGNaYW1pUXFvK2tKN1JXcC85SHRINmt5VXYyWDlV?=
 =?utf-8?B?V1pWTFIwTFI1aFI2bU1PamZ5bktQSGk5elVSOWlUZXF6czFmODNmSjA0b29N?=
 =?utf-8?B?ZjlVdVh1RUd5a3pFVnYrUVVCdlUwVy84SHBkMEFRMmZaR05WVHJ3bUswaU9w?=
 =?utf-8?B?a3QvRVJIN1d5MTlyTXBjamdSRkRYeU9JWmorcG1PeTJ6Z2Zlbjgrb21GenhK?=
 =?utf-8?B?endyU1g2Q1RVdC8zeHJXaWNQY0lSL0xobUJCeTVNUnhkQUU1dFJPZnppMzhH?=
 =?utf-8?B?cUN3NmNFK1NycjZtVTNUcE5LREtDOUd5MjRUaFJvYVJGaW9kczNtV2JVd3ho?=
 =?utf-8?B?c3h5Y29yc2VzaEZZdDEyRUZjeUR2Rk5EWFFmMC9IYkNHSm1jSkdpeDdjWG53?=
 =?utf-8?B?dkFXM2NVbE1BZHFiTGNGRkZhNG8vZm1scW0zRFJIOWRaL0JMdEFPRkFSUVVQ?=
 =?utf-8?B?bVljQ3BVY1FnVllyOHNSNVMzMityalBiQys4eXM4VEwyS1FGb0x1cTRyRjRE?=
 =?utf-8?B?MW5MMkFZMmlqK0ZKaURJazVSVVpyd0VVSlJBRHI2SnEyS0FLbG5sYittT3cw?=
 =?utf-8?B?L3Azd2JmdE1zZTJJSkNHRGcrNkVoWjBDSDVnL0c4UjJOQ1dmbXhVWkQ4M0J6?=
 =?utf-8?B?cHVwVEJnWm9PbFF1NktyYXNtT2dIaHlycmVWMjdFamc1TEVqL01rRml6Z2VS?=
 =?utf-8?B?OVFWL3FhWTlqWm5HRGt1R1hOVkdrdG5wMFYxVG9nVGZEUDJsdjZ5dXNuaUNV?=
 =?utf-8?B?Lzg3RHhodU1VU3VDRVpHditVZ3U2Q3BQYms2VnhoVGQ5Q1dCdVdvRkUyMUdK?=
 =?utf-8?B?M2VFc1lmRS93ZXhCYVAvemFqT1d3UG04SlVOdThJWFB3VExoR1JWWnQxSHBt?=
 =?utf-8?Q?1PNVAMbBaI3GOzFdel+zjeZrNkaPFDDhfXi8iMR0Iw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <523AB0205F5F684D89A1D69B59F02D0D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YdnqCxFoaZAH40JabWcCrNSWwQl9Vb1IIHlMc/4ow3mPVNAAKJtPwAXX3U7rMPpc9B5qSVHLqNav6lUwKBG858lXTECdcRt0ltf2PB+0wNDebpP3UIj8A6vai3Jg+qSK0mdHVZVqhjxgWqhN0jaDz8XRQVwSQN5YLSDM5zTngk+4g4QGNWk/L9uuMJvomi5aVECEzfODQeiVZEICoLY/CZ3cZvTgkHs4HAZ5OEgjNKdSsFhE/Hq86WQZNxsfklauDzmCZhvLcnfKY15lj3ql9GBImXe1FInX9F9iVWBTeFjG4iVaZln+PymHjA//N9zPWMNSPXBDrD5ZuYJ9Tht3GBr/eulydvtOsKaQLx9k2Y28zN+bKm5MX8I1x9IMetiTPaqEH1IB2OFvOALfeu1nA/rwF/oCFyAzQxf3dgSPHkozU5t0IoQ/KDS+nee+SSa+j+vrB9fhyg0WHNCg8UnPZ1K5vmUx3WYJXn1ZrjlkaQGlnx9I2WkQ+ajI3RYeBKK+lq35pjzyXb1nkwdF0wbC27JuPx8h6/CexpRyPxbBTRds52FHzezKaSXXkNM++R294Gpw/wpZIfsKPuG3zh7bMBj35kbDqSckZoZOXY7JltS7EQa8ke5GMBQi4Kz1xK6vVSmrK3d9MQ+y50LohPGM8NEG3Oz1BnlkoYCuXvVWxG75gsy4Yjqd/nNM4q1K/bYHmhlVMKhtorwYMqdZdMPRWg1AKdnvy5iXeds5qteheK4sKR8TiIT/nXHLn+KPKq0eM1UqGgyelehEijg+cv90hBMPLXB18ql5vaWcxP3JzEdBIeRfANVvUiH3wXeMoNed
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3caf1b-5de2-47f9-c3a6-08db20b5aead
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 15:48:09.4693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KXQ/bOBxh6T72aeQxpHq/1OdxeUBXutw9J34pQCmIlOgIsufoT6Za/ND3O7gg3cSg4W3fYkpYIzmnWzQeLnByBK981N0xrPw/JHzHY07Wyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1016
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDkuMDMuMjMgMDI6MTQsIEFuYW5kIEphaW4gd3JvdGU6DQo+PiArI2lmIEVYUEVSSU1FTlRB
TA0KPj4gKwlpZiAoZGF0YSkgew0KPj4gKwkJaWYgKChmbGFncyAmIEJUUkZTX0JMT0NLX0dST1VQ
X0RVUCkgJiYgcnN0KQ0KPj4gKwkJCXJldHVybiB0cnVlOw0KPj4gKwkJLyogRGF0YSBSQUlEMSBu
ZWVkcyBhIHJhaWQtc3RyaXBlLXRyZWUgKi8NCj4+ICsJCWlmICgoZmxhZ3MgJiBCVFJGU19CTE9D
S19HUk9VUF9SQUlEMV9NQVNLKSAmJiByc3QpDQo+PiArCQkJcmV0dXJuIHRydWU7DQo+PiArCQkv
KiBEYXRhIFJBSUQwIG5lZWRzIGEgcmFpZC1zdHJpcGUtdHJlZSAqLw0KPj4gKwkJaWYgKChmbGFn
cyAmIEJUUkZTX0JMT0NLX0dST1VQX1JBSUQwKSAmJiByc3QpDQo+PiArCQkJcmV0dXJuIHRydWU7
DQo+PiArCQkvKiBEYXRhIFJBSUQxMCBuZWVkcyBhIHJhaWQtc3RyaXBlLXRyZWUgKi8NCj4+ICsJ
CWlmICgoZmxhZ3MgJiBCVFJGU19CTE9DS19HUk9VUF9SQUlEMTApICYmIHJzdCkNCj4+ICsJCQly
ZXR1cm4gdHJ1ZTsNCj4+ICsJfSBlbHNlIHsNCj4+ICsJCS8qIFdlIGNhbiBzdXBwb3J0IERVUCBv
biBtZXRhZGF0YS9zeXN0ZW0gKi8NCj4+ICsJCWlmIChmbGFncyAmIEJUUkZTX0JMT0NLX0dST1VQ
X0RVUCkNCj4+ICsJCQlyZXR1cm4gdHJ1ZTsNCj4+ICsJCS8qIFdlIGNhbiBzdXBwb3J0IFJBSUQx
IG9uIG1ldGFkYXRhL3N5c3RlbSAqLw0KPj4gKwkJaWYgKGZsYWdzICYgQlRSRlNfQkxPQ0tfR1JP
VVBfUkFJRDFfTUFTSykNCj4+ICsJCQlyZXR1cm4gdHJ1ZTsNCj4+ICsJCS8qIFdlIGNhbiBzdXBw
b3J0IFJBSUQwIG9uIG1ldGFkYXRhL3N5c3RlbSAqLw0KPj4gKwkJaWYgKGZsYWdzICYgQlRSRlNf
QkxPQ0tfR1JPVVBfUkFJRDApDQo+PiArCQkJcmV0dXJuIHRydWU7DQo+PiArCQkvKiBXZSBjYW4g
c3VwcG9ydCBSQUlEMTAgb24gbWV0YWRhdGEvc3lzdGVtICovDQo+PiArCQlpZiAoZmxhZ3MgJiBC
VFJGU19CTE9DS19HUk9VUF9SQUlEMTApDQo+PiArCQkJcmV0dXJuIHRydWU7DQo+IERvIHdlIHJl
YWxseSByZXF1aXJlIFJTVCB0byBzdXBwb3J0IFJBSUQxeCwgUkFJRDAsIGFuZCBSQUlEMTA/DQo+
IElmIG5vdCwgd2UgY2FuIHBvdGVudGlhbGx5IGVuYWJsZSBpdCBzZXBhcmF0ZWx5IGZyb20gdGhl
IFJTVA0KPiBwYXRjaHNldCB0byB0ZXN0IGl0cyBmdW5jdGlvbmFsaXR5Lg0KPiANCj4gDQoNCkZv
ciBkYXRhIHllcywgZm9yIG1ldGFkYXRhIG5vLiBCdXQgSSBkb24ndCByZWFsbHkgd2FudCB0byBz
ZXBhcmF0ZQ0KYm90aC4NCg==
