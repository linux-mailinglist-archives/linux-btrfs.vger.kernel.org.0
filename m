Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CA36BD6CF
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Mar 2023 18:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjCPROz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Mar 2023 13:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCPROy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Mar 2023 13:14:54 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F8618B3F
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Mar 2023 10:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678986892; x=1710522892;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HENsHP1N/cAGZz839LoR3PZ9IsicXEd2P6lyhLMYvhU=;
  b=aK0uGUPIu5T3+FgcqzXgY8qFbhLYCGrm8ztWkJeOdHvCo3uBMx7mDBgB
   6oeAKE1ol5UzE6I+eqT4zpNNP7mkjpJJhElv0T0hccb2+r45KiyFuidlV
   6PXuuuTbdZFpYBQsHp5u5GsnCP+Fwm8gSCtTbLIfAxpOFubpwgmA6PClh
   b0p2exhMH2NolTS1Ufb3Cj5H9pokYfHXKJ/AlL0E+6SLa7wy4WJGXwCux
   0Cb3mhfAJo9kTjzc5NVM2L7BoQE9RK0KrXsBCQhi82ItcDfRyLfCtt6av
   MsgGp5XTnxlJT/N/2xh8apnWNnR7GMQUKHfS9cg26ljhUhBsB7aOAR+fU
   w==;
X-IronPort-AV: E=Sophos;i="5.98,265,1673884800"; 
   d="scan'208";a="225799274"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2023 01:14:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imiOXLbKhCYSMPzhL8veiv82VTZN22UdMLZYoOfCWO6/WqZMVXWOGd9+29imMt0O3XUzIyuQ216byDXc0CHuueEw2THH5onR4rHctqvGNBuYl/6AlGtMl7igivR3bmeH+lBuJGwt4Ii7/LIumSKqY4HUsLve11jttmtn0MbDqRD7hh2ePQ2q9mHZZ+5SzPAhnu8BCmSdWD8yF+US8maVKEFwSCPJy2i1tXhzpGLXcEzg93jRLOhamdRy5BdyF7saJakC7+2gzaRdwF+5pdX89M954swMEiAx8gT7EBQCrUdsAVFgZbDVwFpcqmUmtX1AUI54ZBf6+P1arRXg82B8Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HENsHP1N/cAGZz839LoR3PZ9IsicXEd2P6lyhLMYvhU=;
 b=DsTRtDFO+Zmb14iT2rY5TlYr80n4xe3P9qRvX5cTyZuI50ezN/4i1kIl6wW6e75CtIt4Mm5U3acQTbbVHGmB0WrfD76ygrvO4KnWh5ByyCBA8PhiibXS4ywZB4b7W/hik4YXNZjnS2BgqbpqplU3/IySpiMSQxYjcL7xGuy8PWpoTA7Tzm3UhndrcwVOsYWGRPwGS2sEIIcJWjhVUjItzUZyTnYdMepyqDUbDuoP/Oic+P9QTEIgX5dV4HHs6Nh28H1y4bMJV5WT+JbOtA3HnYGRgY/UPyi7hh+jpYgW39pfi5kpgSF9T7wFGi/sqGDBa8TQD8a5xNLSSZFmXX+Ouw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HENsHP1N/cAGZz839LoR3PZ9IsicXEd2P6lyhLMYvhU=;
 b=E5+ZbfuZ926rup3711VKMYGRF/MjG92RdL8EkhX5DR5+P78Oxz+SffPdDbhd0EZZZ4GRXXVCeapmwOLX9WVr0wdqf/zWp6d+3JhljcVPkRs3hTeAHqWs2noBaSZbm7gS3MVo4bXFh86TzgAAuJ0YMxWgTaPVIqAuzR2XbiHjqHw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8663.namprd04.prod.outlook.com (2603:10b6:510:24a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Thu, 16 Mar
 2023 17:14:49 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%8]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 17:14:49 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Johannes Thumshirn <jth@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 03/10] btrfs: offload all write I/O completions to a
 workqueue
Thread-Topic: [PATCH 03/10] btrfs: offload all write I/O completions to a
 workqueue
Thread-Index: AQHZVpZfCyxZxgAmwkOwLTFeREU16K79qHIA
Date:   Thu, 16 Mar 2023 17:14:49 +0000
Message-ID: <6b608ab6-3204-21f3-cda4-b8bcafd22299@wdc.com>
References: <20230314165910.373347-1-hch@lst.de>
 <20230314165910.373347-4-hch@lst.de>
In-Reply-To: <20230314165910.373347-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8663:EE_
x-ms-office365-filtering-correlation-id: 85d0bda1-82a5-4ad1-05b2-08db2641f2db
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GXDIwI9aJQCFjbPDOipqqNFUAUcTJ+udDAI/IXSmK+a3sTsMhB2Omiwn/+PPt+yvEq3nSSoyeOciv8VqCERctPxfcYpkJguZUlcbRhejx3bcRBsveBkf/x7OyNnqKZK0L5CNG225CBjlvpnvoFPRrDVSqwh2+vNTOXYaDAsin2NH8lwAHe/c1CppYuaSR5Moc7F5KRCVvs6iPpi/RIFOTczBM09ii0KaCsiY0uUo1O+iwzghwAm8UAKi7XU5jOmS0+nL7vzzY55F7jcQrR8BHEDhoql1AnSXBpHkNaNP1XlQYcJ0nHO2sugFyVAICjZ+N2GUxFSwZ99FcCNmNYRV/bObA7HAakE/ueBXXwTv0RDRCyv5dWi+e49Yo3lYHH+ddlRYx0L7nBkBcvnCUfzJRbD2LcQPZ1W4GTcdzCraqMSo6341Yb63tEZqiwZ388WOD2ZbiuvKpfc+Afdy8Eg35/ShjYXWh72niC15OpmMySy9RS1h7w1a2fPG40HWs5IIJThA5C1uIjbyx2KAe4kRAFahDJkw5TiZAHo3MfMxur6HXqKr+gU0kskfU54pS0nzZT9nQx3KPQF0rKFMtrJLE2OWkjTWLYyUsLlBoVZqiDjwh7KxbuXZX7l8vGDNvrXSFBnWFMIqkvhnAKAgoXnvk3wIk3PnksIkpomnKtxDwEn1oLSBFrBdkq1vxhyQb5vTViXdYXCiVoYRQVo7HbK/VXG/cwBjCJdiyYDqAKSoBvfDhAgZHOGJc2MeTcQuICK6t1Ln1LHajb98QN+MWN933w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199018)(82960400001)(2906002)(41300700001)(8676002)(71200400001)(76116006)(64756008)(316002)(66556008)(91956017)(38100700002)(36756003)(4326008)(54906003)(110136005)(86362001)(31696002)(66476007)(66946007)(478600001)(4744005)(38070700005)(5660300002)(6486002)(66446008)(122000001)(53546011)(6506007)(6512007)(31686004)(2616005)(186003)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUhxbThUdDdibXhkQVdwVks4Vkt6Q21iZTAzZzgzWWtpUlE5ajN0QUhKSW9k?=
 =?utf-8?B?bUNZdVVqTTdwMFJGNS9ocFVWMkhMM3dubk1lNWdqbjl4QnJIYmRqWUJ5azZx?=
 =?utf-8?B?ZVlYTWZNTU9UM3Bud25PZXRLck9hNm0ySGIyb250d04rVDFYTnI3OTJOZit6?=
 =?utf-8?B?d2o4UTFxa29jNGZ3V1hHbnA2WUJSbUdnWHVqVDIrRFJuYTYwbVk4blladExO?=
 =?utf-8?B?Nm41RXF2N3pKaHV1ekhGM09lQ2hJT25SWkhhUnBXSHNxUWFtQ0MvOU9PelFM?=
 =?utf-8?B?aExQaldwMHowK1pNbmJPMXI4VWVGZnlYTWQ4VitWTDZtaEJVT1hOQkkxVit1?=
 =?utf-8?B?WHVyMFpRMWRQQmNIVnBucFd5YlY4VzJOUkFlazcvcjNRYU0wSTltQlJ4c2U2?=
 =?utf-8?B?OEhBMyszaEZ4d3lvNG1MeFB0K3JLNWFKZW9ONExsbzZoeG95aUdQYnFJMlZt?=
 =?utf-8?B?aGF6TlVkRDN5OTFlSE1mTnpqdWFOWnNlV2ExamYvbmQxczR3Z2tUZ3FNM0dr?=
 =?utf-8?B?OS9vM0NQUmwvTXordGlLblB4NU5jWk11UHV3dWlnS0duLytteGpvMmVSaEtj?=
 =?utf-8?B?T1UwdmRTc1FLcmUyY0lTbm9aRDdVaWQrWGJkQ2RsU2hXZmxkbmNlTHpxK3BW?=
 =?utf-8?B?M1ZHWXZwYU9GcDRURkRXVkVNdkFZQXBhNHNTYlJwUDRNc2NFUnR3dkZiZy91?=
 =?utf-8?B?NHZMQXJ0VlRVUnVhUUJVSytNVENSREhOQjh5M0lPSXpLbGQ3cFNLT0ptWnNq?=
 =?utf-8?B?UG5PaW1KekdDMi90QTJ1M2daTjhuQ1BiSzFBNW8rQ0FMRWlHVnZsdjR1bUdr?=
 =?utf-8?B?OEdEYno4YnFUeGNBR1ZHZUp5aU45cUxCaytRY1J1VTF5YUFsK3hyZGRjTEEv?=
 =?utf-8?B?d05ZazMvdExYd3RzNk1QcVJFVldITThQWjRBTUdXYnNiRHl0TEZONDVmV1Fj?=
 =?utf-8?B?TmZaUnp6K1N1U3VteFZvTzhYQUkwZ3A5dlVJdDFRd1EzRkpuQjV3ZGVZT0Z0?=
 =?utf-8?B?MlUwZ3FzRTgxNUM3eDBWdVl0ZkJHV1dwNXJNYUtrbFIyeVRkQkVGRSt5cUQr?=
 =?utf-8?B?VGo2U1lOUjVKa3VLTTA0R1VveTk0Sm9ld1RqUFZ0OEM3SUJBdm56M1hOYmZy?=
 =?utf-8?B?N2pWVENMUUNIL21nRzgvSUc2eDloeXA1THFXanBvNTNhb1p0Z0xJb05Dcnd2?=
 =?utf-8?B?L1dMWnhHVWFsb3p5YlQ3bjJMYk1CTmVOVWhqMU1CZVhqaDdaRWVxeVR1aHEw?=
 =?utf-8?B?azN5b0lpTk5qdE41ajhISFZzSTN2bGs5TVJpOVkxTi9jSDF6REIxOXljS0pT?=
 =?utf-8?B?c20zTWZFamVEZWxiQjVJaWlSY3FiaDVmZUVNZjcwU3BsUGdvSUYwUmhwM3hR?=
 =?utf-8?B?NERNL0c0eEtEaC96dy9jeVFGdEwwOUdFcHFsdzFFR3JQL29YcHFFdEJEbUI3?=
 =?utf-8?B?cUFNTnowQjNwNmdnMnc3WldYVTU2TlA4WEIrNnRsUjJjOXBTRENvVU45ZlBX?=
 =?utf-8?B?SGZCRWJWZnI2cnY5WjhOam93d1dXRDhmQnR5VUdUeVBLQm5EL1cvWTRtWUpo?=
 =?utf-8?B?YU03UVNmOE40bHhROEpuME5UWjl1cFdxRU4xKzJBUG1FOXg4aE5WLzYramRL?=
 =?utf-8?B?NGxrMXdadng3Y0NhbFNpZXR4Z3V0bTl3c3ArRVBkdVljSEVRa0xyM0VTVGxR?=
 =?utf-8?B?eHkxWjlTTkZneHAyK3ZSbEdsZTg5MTI2K1ZLdkJNQlNJb2JLWHRPeEQrZjUx?=
 =?utf-8?B?T0xiS2ZlS0tHY29zNWJmUmVDV1g2R2RDaVd0dlVkcEtGc3pxOFpVUEs1T1Fs?=
 =?utf-8?B?NE04c3FnalBodUcxUTlRN0hici9CKzFtVkt6bGovcy9qci9XRnlkWDduVXp2?=
 =?utf-8?B?bVluZXJNVFlNUDJ5dG9mVjdmbG5zQnRUejdaNzZ6WkNoWGxlbFF6Y0VkQXJ4?=
 =?utf-8?B?dHlFWmU2K0E3dlZUNS9kVU1YMitJQWlKSmtmK2ZaQWQvTEFhVnRBYU1NTmU0?=
 =?utf-8?B?R0UyN0lscFBSbW42L29vNGxST1FXOXVQYTlZL3I2a2pmaHVWYzZna0dwSVZW?=
 =?utf-8?B?amFXTzBiYjVmQWRWTXlDVkpGTGRoUmRROFgvckRycFJFSVRvcGxBYWs1TzNP?=
 =?utf-8?B?QThBUHZ2dnVBQ0NtL0ZRR0ZEaGsvNEZ1YVpzVG1ZL1l6VXdJaG4yNDZEdUxr?=
 =?utf-8?B?eDl2VktjVzkzbEsvcXcvb0ZQVHR6TkFkS1dVSHphTnZON2h1di9mTDRBOXJ3?=
 =?utf-8?Q?YsnzKf/BqNcqMDuILu32Cfxfj53b73xtaNTZ43xbpg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4309D31B5038244F9FCD687E9ACE618A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /vSCsBMUagzYMZ9Smq4JdK5kfdAbirp1szg+bhfnZee3ZnFOlTmmqcPgUBw1yxtftM/E3e3VDPXcSs0vZ0AuyoQZDmptCpJYZJkFjRzYDHGJYlq5/rJJHbelbY7AprImlbqbmZpB69fbapIpwTsyLW6YieUhX1nRebA2EtFZ1bYp9f0gK+Ng0Vbw1101xOcw3LPu5wk0jKsjBcoC10tMuKxYa7/Hb2H3Go4O1zgSwdnyrQV2uSv6eMPa0qf+TanQlKPtApH6uc4jm1oivjwQ6CjF93D+vL+5hIKumAXO7jMJt4kwb2OaYj3OCqe5zplsO9/dVzBzDUrS3U/qzC+miuqYJZoNnNicY9vyvOvDXlvWtNDIf2+JZJmyzkHyJDnZ8WP2jTm4YGnGkh8r0NlP3LD3zl0fZ+WLjp4NSEzAea9TcAFbBJggm+EB/20ypHgBGQjL1bZxlpDAXlfR3bqqiX570p4N1N6yx/yd8Fdj7RgBgnPpDO+qAbK/bFo3EE7BEUtm1Rf9gmpal/eNsTUifCKfBBBKuZA89JpYBrM9t3NOzLpTYLF7212MInlmHjl9PsD9DZfHIq5A+uPm6A4PfCPBwV/lV9pTHrNseCXbd2mFsDL7BfDQ8Sw9PIBh1N90cgP3/2SJgDVUoaRThm/QSXuGLMXssh2NAidvy9sJSBd2KGS2gnRE9Vzg+qjkU1dC3t0L0unVQMlUXG6YoGrN7Vh9W3dfVDh73n7tEHkpgi/zbsoK1BlzUjKq8DdvkZW3tTY/a4FWExtXGZIaG6Z+Wtm5M7H52dR1/RWnG788yNKqZTgCBKAQ1hmrW8vq7lIkc7EGeRFeHMkaIuhx1mETc3sSAUzua7lu10xjZyvSY0bmRv5Zbo3HqHGN48zxDxqHqg5tCefMDhjGgaSV/uNeGYbSryYJbnttscz/eARJ7Po=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d0bda1-82a5-4ad1-05b2-08db2641f2db
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 17:14:49.1602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1bYNQ0QBuGAYwb2rHkzHhHwK+emWEx0nyHqxOPVYFB8/WkzffNhyHev5wBsCdJtPA7mW4iKC8KAlkn9qmU6vtebib3cKxMsqkX4ZlKAMmlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8663
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTQuMDMuMjMgMTc6NTksIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiArCWlmIChidHJm
c19vcCgmYmJpby0+YmlvKSA9PSBCVFJGU19NQVBfV1JJVEUpIHsNCj4gKwkJaWYgKGJ0cmZzX2lz
X2ZyZWVfc3BhY2VfaW5vZGUoYmJpby0+aW5vZGUpKQ0KPiArCQkJcmV0dXJuIGZzX2luZm8tPmVu
ZGlvX2ZyZWVzcGFjZV93b3JrZXI7DQo+ICsJCWlmIChiYmlvLT5iaW8uYmlfb3BmICYgUkVRX01F
VEEpDQo+ICsJCQlyZXR1cm4gZnNfaW5mby0+ZW5kaW9fd3JpdGVfbWV0YV93b3JrZXJzOw0KPiAr
CQlyZXR1cm4gZnNfaW5mby0+ZW5kaW9fd3JpdGVfd29ya2VyczsNCj4gKwl9IGVsc2Ugew0KPiAr
CQlpZiAoYmJpby0+YmlvLmJpX29wZiAmIFJFUV9NRVRBKQ0KPiArCQkJcmV0dXJuIGZzX2luZm8t
PmVuZGlvX21ldGFfd29ya2VyczsNCj4gKwkJcmV0dXJuIGZzX2luZm8tPmVuZGlvX3dvcmtlcnM7
DQo+ICsJfQ0KDQoNCkNhbid0IHRoYXQgZWxzZSBiZSBkcm9wcGVkIGFzIHdlbGw/DQo=
