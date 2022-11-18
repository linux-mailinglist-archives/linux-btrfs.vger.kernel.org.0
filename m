Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E43C62EFA7
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Nov 2022 09:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241575AbiKRIgg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Nov 2022 03:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241499AbiKRIfx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Nov 2022 03:35:53 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F548E0B0
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Nov 2022 00:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668760529; x=1700296529;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=Ks5hZ03GSXDmZtyQVjluLAE/m6vpvubpX3AQlPyft3hVbyBAio4QllsZ
   XsmUXi/CaRZVYmbz0YfVVsShvN46OzFYhKFWnoq1zYVwKoVAy4n19NgtJ
   CYFC4xOz1+qKpeoYzriwt23uoOc6CGq6wemEBmmw942F+d0mguvciIP0A
   cj72NiERgwIxbaNSVgmiRjlDpvnQgRWAgGGN6FEyRtF+LWO901mRlziNA
   CyztBEldEOTznvxvyRrNzSHCM4uN549FFbi8agT3lF+jLkhcyVA4/Kfvx
   TjrdFCOleTQjmTobohX1KQF+pctTT5n2zNk7LgpcLk0zmTqEy5HBrNDUH
   g==;
X-IronPort-AV: E=Sophos;i="5.96,173,1665417600"; 
   d="scan'208";a="320937706"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 18 Nov 2022 16:35:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8ufv7vEOrg0RjvwFNmKmzYqRokH6ZubV6fgpZL/maX3MLLLf9fv/5qpi0z6bur+zca9dquhT42+8lVLUNZMUAjUoGA2oTYLLCNl4VgcLksu5pi+YOPXXBICU7tn4BuhFf586KVSGK/XTyUkr6R1IcBoHI9cdGQiQNFOJ2y/jwh1VDneLIihso6iF2b4eNvqfwNzDiP98YWY/umYuN4/mSle3spj14rwTT3V3w316Royao+hKcKNHVpej3UoE5Hj0Q304mVasTJusIyckTKvcGWldUcvaMnWkUnFeOs3lZ75K4COR1VOWFdKuLUbKpV5Fgu6v49vQX6+fk4QXxYcwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ONuBIJQez3f/xRTOO8gXdYGJWQPslnv31Wtv+08TH1Sfak3QyWViSm+MxQKAFSeoMTE8ASz1XkTqb3P1ouHw4ZQ0VXGIbymxVCXmPZHoHBIVqzT04992o38WDroeYmVsOLIoZNVQXSzBs5smW3ryPH5bqvVSWMun64mkATOjXIJX1ipsAUfrf2iRmYzMmh/4/ptPD4zYle0gr4ETjO/5s3PEvHCNWhq2kSmuv0SEu9i2s79foSxlXsn8SN4C1u26nD/0AN5lnhJq4pJkZJWQ/FEn7lVVuw8FrM3Fq8/F+n0JcI0Quj3CBUXBwcGQnf/GgtjulHwjJQ6Vp9FlZjKIpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=fouFtq8NGXblCJGO82jewgvF6SVwPyM2JURowWWMEgRJkP384yjrNrv4sxkTBPEMwL/gbfo9CV2nx2YX283Rnmye1QaBCJYrj7TZBocZkSFWs/oOY8IuACYaw6m1Xtf6HLsuyTQghC57lvphpKauyL16rZcOblHIYy+qo3czdHU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7414.namprd04.prod.outlook.com (2603:10b6:510:8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 08:35:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4cd:7c80:5642:bf1a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4cd:7c80:5642:bf1a%7]) with mapi id 15.20.5813.019; Fri, 18 Nov 2022
 08:35:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Boris Burkov <boris@bur.io>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 2/4] btrfs: add more ffe tracepoints
Thread-Topic: [PATCH v2 2/4] btrfs: add more ffe tracepoints
Thread-Index: AQHY+fDAVNrqf6AXu0u3712JtDjnB65EXYgA
Date:   Fri, 18 Nov 2022 08:35:26 +0000
Message-ID: <a53c307b-3b0d-695d-76d0-2e46ea1b9ff1@wdc.com>
References: <cover.1668626092.git.boris@bur.io>
 <6663e2f60698f2cb42106b97aa83cfd2a88682f8.1668626092.git.boris@bur.io>
In-Reply-To: <6663e2f60698f2cb42106b97aa83cfd2a88682f8.1668626092.git.boris@bur.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7414:EE_
x-ms-office365-filtering-correlation-id: f50258cf-78d1-4093-5b75-08dac93fd7e6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qt6xT7SAZoIpol3hHaXOPwWCoSwfbhx+D1SHgCWsNsrWNQTgTeow3vkMzcDo83b3pkhDYKs+NedG4QsQzEOpXl7SGXX6TXv2jWV5YLPwl8zvf+jGdF/l+c3P5w4ufmVa0tGxXPl0oNd20c7BC8mGyLUOiWgm5WP1mSY6XHEwEMu1SU4RYezNhge9up9inoJgkXAxMmjTmj25YONRamSvJjjaiqgwq1PRBE4bpuYyWSWCwpAFJsvZzW1ecRWzIAWa/5jYSTCuEv45kkWhLWGI0flixUhoMBi/0op4pavtAXGB7nJKh0WWidrXgi3FUGnH/qsLZzyMjfoKWvbnlh7dLTEuylajbspahbyLTeASoRD3VP/Q+vfZgj+bXB1cvxZ6bfiJERpLlTqBmCL2A9TL4xEM/SCHfVVcdAmVIqWRHEpECzOiGjrduNYXhYtvzZl05e8z0/FLZZjWbeAquYEDMhvbAGhipfKYoPdOPeA25PdyC+ffN22zuUuHVF/DbOYjUi0P81gZLFmrzz3PxqTAolMEIyy6w1Uh9i8f+2leWiX2R4Y3CjL7nk8uPrxWpexWKghKSLQoo9XWajpBox0CD4fj0iONmv8isZkgLiBIPmJpcRPBAiEhNu1ewSt/lF0b1oz0u9BZIQdZ2BKjDmjGLBZNxDGMISl9bNobcxE5FZJnsmTFy8UegDM51KQawWiPWpkFHP4yEqG2YUE5KlGFBHHH1Z4s1/hd8s48WeFL2JVyqxhbTYmeqIoyaUJMlsOnPvoYDgZ9srFLe8mgM+De4DeGC8kurlY4eJkwJYPy7pXSWhZ5k7TpPBdw3dYKwcR1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199015)(71200400001)(38070700005)(122000001)(478600001)(6486002)(31686004)(6506007)(316002)(41300700001)(2616005)(6512007)(8676002)(110136005)(4270600006)(36756003)(64756008)(91956017)(76116006)(66446008)(8936002)(66476007)(66556008)(66946007)(186003)(2906002)(86362001)(38100700002)(558084003)(5660300002)(82960400001)(31696002)(19618925003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGtaM2gwY0ZWU0RXb1RJejY1SmwyU2xrelNrZ0lWNlZ1bVA0eUIvQzlQQnBR?=
 =?utf-8?B?UmV4RzlialM5MWt1THBqVGlDNGpDMktqbytSbUhRaDdpbUFqcFJ2T212S3BT?=
 =?utf-8?B?azduSmg2dU16cjRUckdvL3Q3SFU0NmxBWGVMUWlQNUpvUDVWUXV6MGJqS3Jm?=
 =?utf-8?B?Rmxld1RSdEVEZTd0WUZLWmNmbWwxWHV5c09VK2RZOFRZb1ZhdGxHUFg0UnA3?=
 =?utf-8?B?UGd2dFVTeFlqYTRWeVRUNmpnZVFZdFh0ZytXMng2OXd0bGZ5SEFjbHBtdnhu?=
 =?utf-8?B?ZDI3TlFhSnBrMS83YW1hKzdCRkhjTFVoZ2htalRabTZBSDZqMlFwTmRtSEdG?=
 =?utf-8?B?YlpvS0ltN2lIWjQzRlN4eEhwbU92Y3J2NHR2V0JBY2pwU0MxZ1Q3SkZYTUMz?=
 =?utf-8?B?WG90M0FhOTY4dFFNb01sUFo5cmhOQzc1MVBsV0tkc1dVaS9CVS9XU01GUGo1?=
 =?utf-8?B?SkliRFI3RGJ0V3ZvRjNXeHJjMDBpRWgxakplWkd6UlJxNVVoNlNMN0dyNzM2?=
 =?utf-8?B?YjIrM2dDRDdUTHUzbDViU01obHEwVUtDY1Z3Q0pJSzdMaUpwbDAxaFpUN09h?=
 =?utf-8?B?dXJMZ3BobGlMeFNTMUk0UkhXY1NZZlQ5MEtQamJvV05hMitqbDl1WWhLZUNI?=
 =?utf-8?B?djljUUFiMHZuMGQ0bkQ1YUJSVCtzRFcvM0Z2SnlhcmFwSFpZenlPWWk0aitv?=
 =?utf-8?B?eW9Nb2JRbTF4UGsxSVlRV0pJeGF0b0FvRlQybWNZeUhtVFpqNzRrZTB1djNP?=
 =?utf-8?B?L0txcTM2cXI2VE1laHVFZzIxcEZ3L25YenVoTUlLMlliQld3d0VPSXdiWXIz?=
 =?utf-8?B?OFFFMzFwK2x1UUJDbUYwRlRESW5pdDliNlBnMlArakZ2Q3JBQ0VnK01POFVq?=
 =?utf-8?B?a0VXUDErbVdYaXhsSFNPbDBSaWdKQm53OHJOR2ZhZUF1OHdIWjg3amFZZGJI?=
 =?utf-8?B?UzJYK3JreHBaK041VFFMak0vUXJ0aHRxRTR5UWFFdllUQURKK3RjcGJMaytN?=
 =?utf-8?B?ZHo3SWJ2UHV6MGZhaGQxL3pPd21vejBVam5NVUdIVFJsUXRaZzlmZE5sMEl5?=
 =?utf-8?B?UDViWGJuRGRiZ3JLS2g5am9GR2RvekVzSzhBdHB1Y0p6QUpMaHBuU3pudWZD?=
 =?utf-8?B?cDNGRXlZd011RTVHdE5nRGFYWEszMm4zMUt4V3U4eldoNzZIOGRCV0lPR3h6?=
 =?utf-8?B?RHFnK0tyaWlueWYzaGErRE1DRi94djljMS9RU3lCK2x3ZHVqc3ZlYXl3Mzhx?=
 =?utf-8?B?eGY4RkVMVWJNMHVTV1V3NkJRTUhFaEdCSWpQcTN0aDV1enNnNlpNVWN6S3hD?=
 =?utf-8?B?dzRPdGVrUkRqeHl0aUNyQ3c0akszSGpaQ3dWck9UUHdENkUxT0hMSEVVa2Nj?=
 =?utf-8?B?b1pFM0RuV0ZSNnJUTHluMkx2SmxzUlJNZmhXU29UUGdOa01iWkhLcjhtNTlp?=
 =?utf-8?B?VkNDMGN1czBxNWdyaTdrdXN6a2hBUEorcTNGY3ViQkMzaWZtSmJyaFFsT3dF?=
 =?utf-8?B?cGYyOVhlNWVUMmVzYTFJd2dCU0F0KytQVmlsQ2hrQkdLalBmRzRlNzNkTnVz?=
 =?utf-8?B?UWpnQUd3Um00b0tqZ2pnRzFzZWhXbzRzVFVMU284ZEh1aDBLWE1DdVhkamto?=
 =?utf-8?B?N25LcW5rb1pVWHVxbjEwVkwxYWdvMlNlL2I3QnhNdk9mVHBmZm1LK2NVdENx?=
 =?utf-8?B?RGNTa3dlYmJrT2g5TFRUenhMVTNOdm1ORmNFVm5hcXRPRWVZQ3dRM0t1MlF5?=
 =?utf-8?B?WUJNUy91ZUhyZ0F2cHZZbXdNa3ljcmMyZnR3MWExdnJuNFd5U2J5dEVCR28y?=
 =?utf-8?B?cDlHcmNGVGhWVDNLcC8vSXExUllFaStvWFg2aUFZUnQxMW9hLzNEUnNTcU02?=
 =?utf-8?B?VVZpN1hZQjllWmZvRjAxL2FrbzllS29BSm5UelJNeUZhNEFhYjFxTkxYMjB0?=
 =?utf-8?B?TC9POXBQeS8vNFZkUUVPR3JwUDRucEhzdXNTVFJVQkdBVHMwaHBMT3RnRisz?=
 =?utf-8?B?N0tiMUFzaDJxTzVkRDVmZWRPODdBL0hRQUlYRk5IeEZTQmZIWGc1aXBjMUE5?=
 =?utf-8?B?blpnaXdPbDZiOTBvRXBTMVI2eGlKaklpMG16aVVFaHk0REwvaHZuV1BYaFdM?=
 =?utf-8?B?Rm9adm9JM2xWMlZhZ0ZnaGgyd3lnS2NHQ2NQMnlJK01LT0l1ZmVEZWVPMTZ5?=
 =?utf-8?B?eTJPdEFrZ2syK1FTeUNDVHRaNzhPc2xvbG1BeXJkaUJpWDFSMS9FRHlpLzRs?=
 =?utf-8?Q?ToL5QgLGKrhJkN3Fml601pOcsTMbbMbGhXGwLrQ5xM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8CD0C7F470DE34EA564119288383590@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TMT49gNLydNklQOqJM6PhuM/D9DIgNSeKG3IExZ+CIgv+7vqkSwzyvgLqL44uG8VPLyu0GrDKBBu2MIhgU0V0dfYlPtoa3dH34y1TFgw381QgU78iY664HrTYG2c+fY92qd7hjsbxch93W3tZoqHEVUZSP8ZuWOmHO/85Qt+gRFEVBkNxAeaD5NWjX3tsmazUQod95tNOCC2FJXMVufrwpmhNtJew3wDslQzexfd1KIc6EIdjZXBxT4gp982bjcZjKZQTr6KE7c5ibM/XjIAkpWDySeTTFsgSOk8LzRySwFx8eghG0kTB/3DYWuRKa+NxshI7H2s2oMxsXivqLoqiBO5sXx/m6Hi3aj7IJ13mcBRgUoXotzZiFTfCHPWSLgU7njxbCxccScGfai4naJNv9gNDVA6KJz9DFtdldJeznEf4hxU948YZCwZtpPCa4KdFlIGboXQzhQKmGEfA62Fic6oJWzIQa3XRG8ZOwCM5b6jiNvOGORGoRvy6un85boHU3Y2lV8JjxPOZ5oxah8bSWtvjqfwimxx2tw6Ic16aP3zFxnTeEmF/pUOvsKjZK8dlQv+2JOIj/no/U5X3quYc9t1eE2UCnb1LCaqIkneuzETGnlGlBDftfm36y4FwNlCyVG1TQ0UwEW61mTQbnBrWiIPkMZFzfFrhC6BlNHYLf4ZNfb20Ip6taSk2DH/5Ta4Xsvjxh/UZBlZqp0Ee2yd/5yFxVPACj51FMH70vwADWblbdWZvYgVhv4TQNg+bSWAvQO8stZ7PPu+tyfm3FP/1MidhoeTcLIgct992OBuZIOr57o7FCFiXi1X9ebvLbfX
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f50258cf-78d1-4093-5b75-08dac93fd7e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 08:35:26.8511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r2D5lFeomSOfMG97fAR6OZKw5g3gZ2NeJUGgE5H8xImik9TLMR/ltxKiKXx/B8Dy1eCB1+oF0Jb3ooAq5CafAz0eEgXdW6EGFBXEYPbLVcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7414
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
