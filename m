Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BC266DDB1
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jan 2023 13:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbjAQMef (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Jan 2023 07:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbjAQMeb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Jan 2023 07:34:31 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89152B61B
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Jan 2023 04:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673958869; x=1705494869;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=eIPnXnDsKG+b+iU4zTpQZ4a3wxqR5xovHOsCdaP7FD/iwlpp1e7JCvwD
   5I3D9fqhHACffHMU9zBsh+An7HkyVu9hLncaHshm8Zk2OIRSsjWzXaPW5
   n1TL+MDMUBBzjI9vHinol6T3pTHDzGvBNKaqlM6wjWqTyxhePq+m6CdEK
   VvrYg+EAeLq2ChiAY57SyOLxHn07I6wIoxfOtKzZ/G7bgavq/ftCCz2t8
   QGa4IXkHMsgjdTnspBYDVGTeQDxt10KvphsHDFWdShcTnvKFfV/OQ4dG8
   CHABWy+lJzQpLFEFJteCTMA77iqPVD4X/s1PAl+XNesxd2Nbc9nMhEnRy
   A==;
X-IronPort-AV: E=Sophos;i="5.97,222,1669046400"; 
   d="scan'208";a="220839061"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2023 20:34:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpdS4VqlP8NFrDbpc5kgbQxmppzOp/0b6cxb1hj0M4+4jVms1Xi+U8ZsDdnAFuNMrMPtGk10ZQ9PNPXoRQH5yb3UBZvxYChrjoMFMmR+ultoYOQksiCiCgiGO3L5c39IKKPRQj+bJf35kU+cuduLq6taRUgA1omRQLaLkTC4UC/TbVkuwZ4MmjX8dsAZ0GymBtYsOcaHQXOIU6aMLIEYzCp/Xka06FwkffvrGjATW7sglO3P2C0u2wOvewHAiSs1oIL4fh8pXmXHvI/b3nUWvKWR9j+oeaDTe7DMzY3jwpJ0euMS1hcQzoF60ER/qlnwo5d45/65IoZzw8F262x1Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=G+FRM1oM9DQ+Yff8yu7PSVWdg1fpY04dH5CUfJrdyAo1GnoY7PcNY9GUqf7jP1nH0HiW5n+RgL2WYA90PZOmGOLPA+va6bTtfvjNO5uUJcW87BZUoX7rXfSohR1605uD6KftJGv1IiunHzqmAVIt7lezR6dw6QQJdT4h8E1LhvZ6WXgmih9+Abugg6j7dtkXD19+ZCiPPfyp63ZD16uwVPg+xK1ZEibUfi+0poYVFE0r2y4q1FjxED0mlfe9BjWHbInNFuvZKoUbtnsVTgNAnd+156kz0EWjF2wgZmwdSDEMQ4HHkgevHDYplzVMdfi9lpH8JMiqnIHJjjkpXafEIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=YOFhGdUozKGNxB/eC8Wbn2/CcrAvOq/on02iSfuQ8Lp8pXzpPc3e10PaAd13WdYGpPVLwbAF4T408OsNA/0zWW0St6vI54ffxWbFrFXQdbB6G9dgIntQsU1Xa+JSMs6oTbstsMJ5+FzI/fa+qG7pw541bBH+i9yPgj5BBd5A3LA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6509.namprd04.prod.outlook.com (2603:10b6:5:1bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 12:34:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329%4]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 12:34:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs: assert commit root semaphore is held when
 accessing backref cache
Thread-Topic: [PATCH 1/2] btrfs: assert commit root semaphore is held when
 accessing backref cache
Thread-Index: AQHZKmYK56hSmkuhPUysnlpMnRM+5a6ii0UA
Date:   Tue, 17 Jan 2023 12:34:26 +0000
Message-ID: <8288f4c4-cfea-4fe1-3c25-9eba3952a4c2@wdc.com>
References: <cover.1673954069.git.fdmanana@suse.com>
 <c34488ec6ff0a402978fc1ceb0f8bf923835deb1.1673954069.git.fdmanana@suse.com>
In-Reply-To: <c34488ec6ff0a402978fc1ceb0f8bf923835deb1.1673954069.git.fdmanana@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6509:EE_
x-ms-office365-filtering-correlation-id: 59b2a7d0-4e1f-4344-3416-08daf8872bf3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AuJ29mdm3DlyMZe0O374LNpMfMWchLOm3hXmhiq0kbFvmAwuJHEobD3U4SjvTg0zFHwsBfKI3KjUg7qKBNxLO6tXjARhwSnraZKLGwUloEa0sK3w1DPr2rDXYL0kH4tf/xv8pS+CSfKldWJmjLmEqO4TtepsQ6tKfoqBd7cMmsX40Q1PqQ3IIHuKQzqIO55C+awxpHAGmVnHS0Adb6Jd24R5/atEzuG1FnjzYz2CTmSD2uxoj1two1JhYeusFoRoDx3eucD+ZD7E+ET35VbGZK/B2IMDClBDAJmwDTKaEmhP0b2+LYmuLllTS6aLWtrtlVJr+YTsXVz0i5te/Os/L0bwPMgsB4Yt6zf979sKAj++tcm9MdmA06m2tZzge4CcnJW0MJbS1G8tnQoIS+KGPb1wB1/G7c0SvLgaMWqaqaXDBkfF3piugMIOd/BMyWxEM5lI9Gc/VOoWz/fpxOJC0o7lWqDM7F3Bqmt+Kzkonu09IPfL8598/B9kRhBuMoyDe45XdIA81sAhxDyW6PQTndqPozNKOG17sko44Xrq0PXgFOWpOOuvpkstvn38SZjKR1fnbMYUsHXOfVbAtZAAYmxl6jcrQKvRi78zeLUz7oJq5EVEubey6ACkzOtg8iWM/zMO7ZJUfHlaWDaRsvtMZyzYAEDUhFGhLo4sSRTY1Mhmo9nKsIm7JWSOtKYARngWyBflujP4jjkj78+oXEhpSlVLBPOLhw/OV5f9ptALOLA8Sngl2UL4215b/5kkYGZvjfG+FsFcj3ao2CkuA6GevA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199015)(31686004)(36756003)(5660300002)(38070700005)(86362001)(76116006)(8936002)(66446008)(66946007)(66476007)(64756008)(66556008)(19618925003)(2906002)(8676002)(31696002)(38100700002)(82960400001)(122000001)(558084003)(478600001)(6486002)(110136005)(316002)(71200400001)(91956017)(41300700001)(2616005)(6512007)(4270600006)(186003)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnpQWWdBSUtCOU1jdXUyZWpWSEt5a3pFSGFJcXJsQXhsc2JNQXBSczhma3lv?=
 =?utf-8?B?c0dLSXEwalFQNzk0ME90YXl0eEovUzgvWmRMaXhMSEt4b2pTanVWU3FTYTJZ?=
 =?utf-8?B?Q1lIVGZBR2VNRUovTGtUcCtXeFBhZGVMdkVqQ1ZBUmE0K1BTM0cwVSs2aTBo?=
 =?utf-8?B?YjdDNi9HbEFLZkZaWlJqQlhGWjBucGQ3WmRYbEJRaW10T2ROZXJRV2VzTU1o?=
 =?utf-8?B?b0xCNEk3dUdJYzE1MlI2bkl3U0JaWTA4a2FTSVJ5bGRxT1BDYmtrRE52cjVk?=
 =?utf-8?B?YVZaZE9zbDZlVlBYL3lGL2theE1kcHJBSmxaeHU2b3EreEV5dnEwVUhhcWsx?=
 =?utf-8?B?MVUxVGl5TWR1NHh1b2lqdllFd3UzWWwrMk1SV0pKcyt4eCtPUEI5L0haNzY1?=
 =?utf-8?B?MlZBWWpiWHJnV205T3oyWU1zMW44UWdNL3F6YXFOOWlPY0JLY2thckpMRGMx?=
 =?utf-8?B?MUEwUWM0WFU0MWNJelhjV0JZL1p0N0VJVlVEZjU0dmdFR1lzblF3SGNiUEJu?=
 =?utf-8?B?QndWQjcxVWJ0VGpzL3NaZFIvRjkvejVlUVFLM3FXWlVCVWJpZTBWTm1lRTBj?=
 =?utf-8?B?bmRIZlIzYUZYczVIRUw2RVlzZUZzbWNDeEZtYXNsTVNmQVdJRmREaDZyQ1Ry?=
 =?utf-8?B?S1UvNXBHM085Y2lyUlVXK29hQUd1dTNFTGppQVNmU3BlNUxuYUNKZVhLQkRs?=
 =?utf-8?B?YkxRMTJNRHUwUXZWMkV4VDdiTzUvZitzSFNKaTFkQXhCa2l4MWs3TnJkd1FJ?=
 =?utf-8?B?SnJnYVJxSU1tZXVBZWIrL2VmcThFSHlBU0tTSG9hOWJjZjBGcTVuQmZuU0d0?=
 =?utf-8?B?WGp4ZUQrTWw5Sk9UZXRyRGgxTExFWGxEMHc5MjlFaVkyRjBUK21RdDhVMDJ0?=
 =?utf-8?B?RXdabUViT1JYK1hzZUQrY3ZWTjVzbHhsRHdZRjJpV1hNVjExRjdidW9SQVRO?=
 =?utf-8?B?enVRelVXMXU4UjJRL0xFQVBOWE0yTkZMelR5NkVxV3ZPVHhZOE5sbW9nTCts?=
 =?utf-8?B?SnJab1JiVVBCYnZiSWtZQThmS0NKcUlQb3ppR05KOFhBMnVWRmxuck03UjBU?=
 =?utf-8?B?OHhHNWlWc1hPZk44RUF3YkR0Mk5odElqN0lWRFlWNEVxaGhvRlJRQkJQU0E0?=
 =?utf-8?B?QkRMT252OUd1SjJTYW12WkJZckcwWnFDT1JXWE5LSmxlR2lEdml0aGlvTnFW?=
 =?utf-8?B?MndBS1BadzNueXJHd3FFSmo5Nm9LdVRzaXNrOGtFSjRYbTJ4MVF6TkM4M1BP?=
 =?utf-8?B?d2hLeC9zbFgwTWU0YXNwckJoU2RYWU15a25wR2lKOUcrRkFmNWNWQUVQelVX?=
 =?utf-8?B?NUJRV0w0SWF1QXBLdjZEQ3kzekVnZXNXa0FQcWVPUFRIY09tNUJPUHpsYUw0?=
 =?utf-8?B?SWtkQ3pDc1ZIdWs3a055Rkc5QnJJQ21lVTd4UTdQZUh6cTFMd0gxN3ZEaE15?=
 =?utf-8?B?K0FBUTVMU2lkajNWbzNCMnZKditFMU5lamhjODU1WTQ2WHNLK1ZGbndsWTFU?=
 =?utf-8?B?a1czcXBkQW1JMWdXY3kycEx1cUgrUlhlelZWYmNEQVl0OFdyUkxrVGkva2FZ?=
 =?utf-8?B?c09SQ29JTmxHam9PY1A5VjRhSXJSQnFjSkZKZ0RBY1BiV2JSU2U1ZkRCOWVE?=
 =?utf-8?B?L1dFbW1GVk1iRlJGdTFraXdkMldpZmRFK2M1TUNPZE8wb1JsSi9wZmw0SUpM?=
 =?utf-8?B?SGRmQXdUQ25STXprMllKQzhXWEdWT05SOUF6VkRCSkV2ZFcrTThvM3dUTFdW?=
 =?utf-8?B?U0drYlpKVXJ5Tjd0azQxUjl0a0pLWFJuU1MyNHlocnEvTisybFJuS1FVWnh4?=
 =?utf-8?B?WFlMK01vc0ZDQ1BCRDJISTVIN1RGZnZzMmRmOUEwUjdEMTdQWFZBQkl0UGxU?=
 =?utf-8?B?ak1Va0pKb2N5ZGRyRThNN1B4RExZeCtoT1FhbjNDUWU3c2NVYXh4alJZREha?=
 =?utf-8?B?eksrenp5enQwQkpXZWoyL3A4bFNndUNkSkg2RDhTVlQzR3p0dExVdmw0S2Vz?=
 =?utf-8?B?UVhrcUJYZnErVk5hUUw1Y2UwUENPdnBwdkY3azJhU25qVlo2WUdRcGN2REk5?=
 =?utf-8?B?M2tvc2s1WDd3NGZJMURrY1pibVd2UitTTDdtZHlmR3ZyWnJHaW5LYnM1Y2M0?=
 =?utf-8?B?cXVrSVptbm9VWmV6Z2piK3hrM3NTdXBoalphaXlMazNMb0pEbHdPeUpGRWw3?=
 =?utf-8?B?a3YveWszWEgybmIvWDNEeUVwWE4xd2xQVnR4UHUyYzJ3ZmhveVhSZkVLRzdx?=
 =?utf-8?Q?myt/SZk67zcOAy71N7GQhINqdqZT/YwexPXAd5Qm0U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <420EDD451437EA40B85103947A0F3B8F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: myMvIy4NbX3w+Wk7k91htpbBhteOR+xNwHThaNTwK7a/N2u06mZOBhYdXLHWDtGARGiwyB3mQPdjBfJA3ZUt7x/tl9xULuo+9q/sB0Vl1XgVqjYVZWCWJ5vOS4GHf3jKtdBtALVnwMpaHrahBnQhZuFIBNZsV0BYV6rAnvEYml6zVVMvvVhsTgKES8Y4vis6JZfDqH9MQ5TIDr66rG38xxKFEhSIZ33YcllogrERO2h6go+8Q92c07LJojfPOIh+spmuyUP2fWKORF+JzQV8V11owHj3MJ+pABzISe2QTs4QlyqpkO7qHeXnjltXP5syrFLz5E3ZHDvOUMnoNLjFbEmjp5E2yLV/oEpZXgVYQH2pxfHkd7IOgZSzcmlbmJBXs75ihBVsrqqAXi3I0+ofedzgu1EXFydBlMs1HnW2BPcX/MKiw6NkHJ0ILC7FmwsHeBSJPCthz3AIsAuUSrmCdtmEMnj3lEQY6D6/hPX7DxXseBFaw1gd/3WAI3tN2Ygm6n9yj39dn4HnzKB/csRPuApbrKxARwd4SDZtMG+PXXUQ8JUIhk61ePiuK4J5qclG1aMxYH5u3EvPH1WOaaraKOWcWsDKzY0TsrLhSudU0LYS9ZjvVDdZIFUm8rdTY5/NdPNe2NbrP6ZkJamkM8KovFsPB2wsL7fzx0FshZ+tKCCw6Rg13KmRLzeLoIOAP0PIMNZz2U0szfGYs/kHVM9GUBIs5rqoCE5B6CxGjrTPcVfQrehLNYNZMbCQFajblX/sye68RnOwuBnGLl5MG/tdFmItCKhaTNHG24akr7tMdZ9w7D4FuOHLOgUb/z91D100
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b2a7d0-4e1f-4344-3416-08daf8872bf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 12:34:26.7339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3g06lHiQ7VA5rEPnb7Uslq1oH2IkBYQInQAClwHIG0Csw9keTM/z6902VfB7KB7nm0f1By3shlTwzckhDLHhT02mQ2sl8whYqhgrkEhH2SU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6509
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
