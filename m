Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC55428E71
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 15:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbhJKNqT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 09:46:19 -0400
Received: from mail-eopbgr130055.outbound.protection.outlook.com ([40.107.13.55]:2215
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231577AbhJKNqS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 09:46:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHwzv2aFCM872AqirEhUSWyCufzaPpHOpXtK7XFXFVRX1u6sSuMmX3cp8vSO52YJ6iqMQZkOywzRYCpezrCcH/pdx0erXB33psyVcmczrYY4QmwkE1mhphuX3bYX5D54ved4i9sRICTeuJ0W1ae6dJAFyYRZAEvSdYhX8XGmOi/gH8lR8P8FzD8q0Bph5E9B4BgX5V5igq8FJaW3/etjsM+erc19sOeS/OhTaa1t0iLaqXnRw91a2SkTOPo3IAAxt250bYrV8760wntkQPCwIw23wxDUZEV3IPzL8yELBAo47zMhVb0e3drcMc2CPwxRnlhIiqjhuOAVDnSCwuFLLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTVUWjv2Xw+avppoyfumlm80xbBE83j5GDJX9FMVwgQ=;
 b=SMTLKiEredpE1J6JQ9fxcI/TM49sQE8nXiYKPQeB4V/f3rVw/Pe2v0usliuapNGRHyWBKcP/TPG7o/MbqJPYehJEx3J9+ooIy2W0KVcnZviwaMZOrMzc3l2HSATK8US3B8u00/YoBThLce8EdX+WmTZB21KzPTNAGufmXT1eyGAShh98WKIfRDejuydzvaj2LaO+m5UyBgGX5teCu1sXo/9PnnXzz/gItiwq2LzwjG/q+aBXhJOB63RXRkC40u5jYS9NQtWQ1epydyVFoGAvI/+NaYuaBvxML9OgnY3VYgoLmmrwxVXhDD5jgsHEG6Ip4XaRPsLaR8ot/mFMb4kLFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibt.cas.cz; dmarc=pass action=none header.from=ibt.cas.cz;
 dkim=pass header.d=ibt.cas.cz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avcr.onmicrosoft.com;
 s=selector2-avcr-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTVUWjv2Xw+avppoyfumlm80xbBE83j5GDJX9FMVwgQ=;
 b=J7kbscYZo+VCAmYKJTxc5MNzBMcCxsnaS9Hh2AVJZCHCufJ8Si4bffa3efC73v9AkpDU6yjUeWqBtlw8VP+ApXLCYjCZ7x/4lWL99aI07QfRBkSUOsthWlfAwXSyKttK090IJR20DAf+AgNKq67bNWV+vsy0Izw8mWMLVooOKrQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=ibt.cas.cz;
Received: from DB6P190MB0453.EURP190.PROD.OUTLOOK.COM (2603:10a6:6:32::33) by
 DBAP190MB1000.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:1a1::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.19; Mon, 11 Oct 2021 13:44:15 +0000
Received: from DB6P190MB0453.EURP190.PROD.OUTLOOK.COM
 ([fe80::f8be:1160:d1cf:c9b7]) by DB6P190MB0453.EURP190.PROD.OUTLOOK.COM
 ([fe80::f8be:1160:d1cf:c9b7%6]) with mapi id 15.20.4587.025; Mon, 11 Oct 2021
 13:44:15 +0000
Subject: Re: No space left even there is a lot of space
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <8d31b2f5-5474-6e12-fd9b-56aa378069f4@ibt.cas.cz>
 <4b21c3a5-f8f2-fd25-0f9a-b22cfdf27fe6@suse.com>
From:   Michal Strnad <michal.strnad@ibt.cas.cz>
Message-ID: <7a7d2b07-b8d7-bd6f-f652-1a0646db478a@ibt.cas.cz>
Date:   Mon, 11 Oct 2021 15:44:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <4b21c3a5-f8f2-fd25-0f9a-b22cfdf27fe6@suse.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms070008010506010506000901"
X-ClientProxiedBy: VI1PR04CA0117.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::15) To DB6P190MB0453.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:6:32::33)
MIME-Version: 1.0
Received: from [192.168.11.101] (176.114.240.18) by VI1PR04CA0117.eurprd04.prod.outlook.com (2603:10a6:803:f0::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 13:44:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d653f625-7e82-45e0-0a0d-08d98cbd375f
X-MS-TrafficTypeDiagnostic: DBAP190MB1000:
X-Microsoft-Antispam-PRVS: <DBAP190MB1000900AB7EA9E0131B697D9DFB59@DBAP190MB1000.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J/tHJFC+XZFSnCuZJuyWH70TlK3CpnxTMXkCTg4Ew7ncrkxleDKRhhj8RDcrb7+cppHNSgBCiwOgcBS0XiiSlFDE2RTmS+yUtIKpXT7OBZbDwdOPlbvUJBgmWAxfcljZvPjUvRJa+rvcl9OQluXsmBOz3463zom/SDq/KM9HOsARWFlkDR9yoyRmkshGTjKhDEe7xeHAn6EYP7x7mv5ACTKtocZ9kxmIbbymCFlcSn8HvxRb1vwUNH5B72QjvfzqiSy6ui45cgAmYi4kKtJFXtNB4a8b2H6+mY0mvw7Rc5fHaXBrYr3gqlgWettqhifZPi+9UXd1QINpxlMaCC0OTZ8AvMJLNCAs2U0pcNIj2tUBqhL9OLfY2TiX2Ovyaj27v35t9gQ72VfjenDkZ3JUeP/WpCNm1Amd2Y13GIotSel9JXXbZhql2UttxMFLhq1IOX+FBxjJMXjEBNJmnziJZxPewo0zOe2eFoDlygAfPRpwoaCzjnSd0kTJD8QCL3MEA4sJnuoej4fzrncSY8z6rWgxZSXcCJXEYv2eQzY29WSDefmaj2JTkEIQRn0EmVmwxGJa8gEG1TqtBZ+7CXnrS000OthogY2dpCVjjfN6rQiWXHxVEicxYKXZ8/ITUG8B5gI5bSZ3nTuBWsa6w3S59GFXpIZxwJo6PrEqH2r3AjSniYXhbXFY9VPANFfI8w61HKUnheMyl4bKnVObGAzh+3cO81c7bG2BytJ9PXUOL9l/UTFdwuzGY1vS5cB6m0pIX28QJdZEUsWJrwHuZ+dhHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6P190MB0453.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(26005)(8936002)(31696002)(235185007)(5660300002)(956004)(2616005)(2906002)(16576012)(316002)(786003)(52116002)(8676002)(33964004)(186003)(53546011)(508600001)(83380400001)(44832011)(6486002)(86362001)(66946007)(66556008)(66476007)(38100700002)(36756003)(38350700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnFLQWtwdE81RkNsTno0YTNEUjRmdHp6MWpJVnoyTFNJS1BZK3krSllwL25K?=
 =?utf-8?B?dVFWWU5PTWZuMFcvWjB3OEVjQm95RjBTOXc2YWRvRkR2bHU3bzlNSWtZcThR?=
 =?utf-8?B?b2dkcUdwRWR5cEtZNmpZUVNGZGpKOUJPQjJjZGQrY1RxWEZBQlJkbG9rRXRQ?=
 =?utf-8?B?SXBxVnVTYUUzV3c0SWo4TkFKekhTdGtHWWtGaW5PRjE0VDI3M2h2ZW9ic3pW?=
 =?utf-8?B?RjArMWdXVkVEaUtnTi9VbUZJK3EwRHc5SFFHeVRWR24yVU9TRnhkcWN0OXly?=
 =?utf-8?B?YmFXRnF5MXNMWitTZFR3QXcrd0tLWTRGOEdiYTcxZFJSWitwNC9Kai9nNHpz?=
 =?utf-8?B?eTdzWndnNGk3dS9HKzRBaUpkcmU1SUliRm13eGpLRVluREVCdG9LMTQ3Mk1a?=
 =?utf-8?B?anRrOWplN2JvQ2lVd2krRnM5T0lOUHQvamFGb0NGdGorR0pxRW9yOENhY3pJ?=
 =?utf-8?B?MDZ2a1QrSkNQSTVPdUpsN3ZZUWJOVjdJY2syODkrZFFHdkQ4RXVDYkVvenFw?=
 =?utf-8?B?TmFEQnpsNFo1S0dJL09CeEE1TTVXTjF1aEhxTnhjZGJCMmw2M3FxZXA2TlF4?=
 =?utf-8?B?UjhKMDV5VG9xcC9qOXEzYVVxL3diZHlrOFp4bWdQalZKMzRYNXdnTkNBWTcw?=
 =?utf-8?B?K21zUFU2ZFBBNU9JZjMzOW00M09SNFRNVWpKYjIvejhjU2NZd0xFVFBQejk5?=
 =?utf-8?B?aHdYdGNJQVk5YjVHRVpDQWRoS0VIZHdBS3gzeFBHd2dnYUsyS1YraDF1c2Vt?=
 =?utf-8?B?VnBFSjlvektSOXRiNHQwYlFVRno2eGxxRDFwYTNXNUhFMGdJaFlWYyt4dkdF?=
 =?utf-8?B?WjRkSE5LWHpYaUJkWXc1d3FxQVNVWE5PdnVLSlUxZW5VczQzdXBFcFI5UDNk?=
 =?utf-8?B?TnlaTFp6MmFEY3plRW1zSGp4MlFzdjNNVnJEWU1rdUJMVjd2dG9ucWJRMWVm?=
 =?utf-8?B?TzJ3aC9RRmpEYmtLbzZwNkFMUXBTb1NETFBtMGRFaTJJZy9VZUIra3ZaZ1ps?=
 =?utf-8?B?M3hGMGN5SG93M0ZEOUV2cFp4ZEpvNERQTzNwOC9uU3pqR1RNM1l2SGwwRTVZ?=
 =?utf-8?B?Z01GWE9aSHZqMmhJamY3alpwY1p0TXFkVkVRNHFmVEg0S0lMdDUvT21IVGh4?=
 =?utf-8?B?Qmt2Q1NSa25wZDFRTHFVQnliL2I1NlgxeUxkb2J1V05xbEo1bTB0QU4wNkZ4?=
 =?utf-8?B?UjBVYjVrV0dJajNQY2RVNUR1cThkd2JwYTFGNjV4N2xCNjdVbDBlSllJeGVm?=
 =?utf-8?B?Y2IrcDFvbFhMcTV1OU4wek5nNHhWbkRUMnlDNmxnYTJpUjY4cXd1cWtVUjdk?=
 =?utf-8?B?Z2RSVnhvWDE1NWFpVWRqQkRiUHN3a1FERmdZaUpGdElkQkZFWU8zN1BENC81?=
 =?utf-8?B?a2RSOWhTZzJMUDVLSW1WQ0NOeEZvQ1NtWHJGRU5PTFlUMUlFRmNaYWRaQzF5?=
 =?utf-8?B?dDFIZXhNUU5reW5ON3c2UTBETGZRTHJicGxLOGE2c01FQS80UGFmU1ZFSGlP?=
 =?utf-8?B?ZnJzQy91NDg4RTNVMkNRM2JWWFRNQ1A4Rk1DWWlFbzBQOFNzKzJzRjl0RW5R?=
 =?utf-8?B?TXB4OUs5KzUyY1c2eUxPMHhsL0YvTmR3b2JyNmRKeVdQS3FyZjVHT21UZ3RK?=
 =?utf-8?B?a09SSE1lUEU2cm45cUZDclJzcHczTWVjTTRsNVdkMmVQaFRnekhtdXd6OHd6?=
 =?utf-8?B?RTAyZ29XSlgzVzd4a0hZcit0czM3bm1ETFhldWFmUFNNaU0yZDBuNGkvK3Vv?=
 =?utf-8?Q?f17l/XXnsZ7HjbtzWAOb4VeKty1NLAofiCzhTkd?=
X-OriginatorOrg: ibt.cas.cz
X-MS-Exchange-CrossTenant-Network-Message-Id: d653f625-7e82-45e0-0a0d-08d98cbd375f
X-MS-Exchange-CrossTenant-AuthSource: DB6P190MB0453.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 13:44:15.6668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: afc43190-4380-4550-938f-a93ad5a5695c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLfzEuCpyf5/cvFDGK9/g0lTVL/q78ou97yT5jvLOHQrweTxxZpA1H5jRL9kkKMhpXpavTaiOk4AvlBko6tVmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP190MB1000
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--------------ms070008010506010506000901
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Nikolay,

On 10/11/21 2:34 PM, Nikolay Borisov wrote:
>=20
>=20
> On 11.10.21 =D0=B3. 15:30, Michal Strnad wrote:
>> Hello,
>>
>> I have problem on production server with Btrfs. I got call trace in
>> dmesg with "No space left" message which led to the filesystem being
>> switched to read-only, but both df (system df and btrfs df) say I've g=
ot
>> lots of space.
>>
>=20
> <snip>
>=20
>>
>>
>> [root@kappa ~]# uname -a
>> Linux kappa.ibt.biocev.org 3.10.0-1160.42.2.el7.x86_64 #1 SMP Tue Sep =
7
>> 14:49:57 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
>=20
>=20
> This is a vendor kernel and it is likely missing multiple fixes to our
> ENOSPC machinery. Best advice is to update to some upstream kernel.
>=20

Do you recommend a specific kernel version?

I will probably have to compile kernel from source on my CentOS 7, or=20
can I use ELrepo (that would be an easier method for me)?

Thank you

Regards,
Michal Strnad


--------------ms070008010506010506000901
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DUQwggZWMIIEPqADAgECAhEA4UndIhoJ6GHY0AfIvqwhNzANBgkqhkiG9w0BAQwFADBGMQsw
CQYDVQQGEwJOTDEZMBcGA1UEChMQR0VBTlQgVmVyZW5pZ2luZzEcMBoGA1UEAxMTR0VBTlQg
UGVyc29uYWwgQ0EgNDAeFw0yMTAyMTcwMDAwMDBaFw0yNDAyMTcyMzU5NTlaMIHdMQ8wDQYD
VQQREwYyNTIgNTAxMjAwBgNVBAoMKUJpb3RlY2hub2xvZ2lja8O9IMO6c3RhdiBBViDEjFIs
IHYuIHYuIGkuMRkwFwYDVQQJDBBQcsWvbXlzbG92w6EgNTk1MRwwGgYDVQQIDBNTdMWZZWRv
xI1lc2vDvSBrcmFqMQ8wDQYDVQQHEwZWZXN0ZWMxCzAJBgNVBAYTAkNaMRYwFAYDVQQDEw1N
aWNoYWwgU3RybmFkMScwJQYJKoZIhvcNAQkBFhhtaWNoYWwuc3RybmFkQGlidC5jYXMuY3ow
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCXANBYdjCR7GT0yjrn05v9Kk5WfbSK
TT/csAtHXtZRlRJ6MksDPMJWG/OEDIhxIQzgSSXJ8/dboH4B0b/mqGOouyL+h2Dzx2C3lIAm
wUQ1b9zi0Mk6dD8grEH3Su2g6/16Yg4Pf1W/9EhW9JK69uFNQtSon88/5CSVVlSKt3tP2fVE
QHqCzjjo3ZnIlgF/ddjonBZdPMZ2isd/0WKrqNHfhcS7oEQzz7AkD3F0Ifm/rg8Qz+Z74oqH
t/xPC0Zm/rFvbRu+nvjRsdHQfZx8WMMvKQdoj3hJPR3RlirGhoTEwE8ZtCAHI8rXP0HFgkAo
1NcqsJxRT6L/VGRt1IV8wqdhAgMBAAGjggGlMIIBoTAfBgNVHSMEGDAWgBRpAKHHIVj44MUb
ILAK3adRvxPZ5DAdBgNVHQ4EFgQUKmhXu3sHZTajVutJhNYFX0KWwUAwDgYDVR0PAQH/BAQD
AgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMCMD8GA1Ud
IAQ4MDYwNAYLKwYBBAGyMQECAk8wJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdvLmNv
bS9DUFMwQgYDVR0fBDswOTA3oDWgM4YxaHR0cDovL0dFQU5ULmNybC5zZWN0aWdvLmNvbS9H
RUFOVFBlcnNvbmFsQ0E0LmNybDB4BggrBgEFBQcBAQRsMGowPQYIKwYBBQUHMAKGMWh0dHA6
Ly9HRUFOVC5jcnQuc2VjdGlnby5jb20vR0VBTlRQZXJzb25hbENBNC5jcnQwKQYIKwYBBQUH
MAGGHWh0dHA6Ly9HRUFOVC5vY3NwLnNlY3RpZ28uY29tMCMGA1UdEQQcMBqBGG1pY2hhbC5z
dHJuYWRAaWJ0LmNhcy5jejANBgkqhkiG9w0BAQwFAAOCAgEAbaKrJxJYO4foc8uAm+71gZP8
P11BYCmZNWoxNAtbRMdD4KmBeeF69GNt7fP/WmC1me2OdVOh2kZzfqhNAowD+5DCFWoukAGJ
QqqcEUzaoIB5KHwxZ5DPzRqwJwHPQCQriMTdgCr9CY2yTpcKs+U1/qzQE3DMsubhUjib05uk
PE18Lk72QiDaj/oFBHHako+KjBp1AssZ9YiUbvRZbk/FrcBPlJUHWUyqUOBGMO+cty3ivqK/
gornGJ56AP/qE0eIN5kG3U07V0a5avtu81nYgARHaKoIg1e/iqvrPPn4uMk1duVxJmYViWXu
akOpOTAEiGWFhaFuE5VbSKC6BlDqOxJpPat69mEAukEkvHpJz5aDxA2x+epxTZWvyRVRitTu
uoTKNr4Kmkmf6KGriQDSX2Rcmze3eH6pldJOivgMutWC6uOLHJuHRLrJ8zwhA95dFqrJ1FFJ
5lU98tU1+WNX49N/5oC6PFT5szDwFt8r7r50oohDweDkGIewKerrBhErkfDriF3N6bPRdH37
YWGor5gbgOhfX0H9w5mH+9pBnTfYZE0pl2lvW/EuonrFmp374sYVjHa6Vl5BgJxiK9vm2OUw
zzyuWYSz3FI+OHXdF7x+Eu3EOYe9b2MAGmP9e4Q0zDy3I8r8tRO4AEx0Cdw9plXYxhvC+bQh
oL33EyUmeZEwggbmMIIEzqADAgECAhAxAnDUNb6bJJr4VtDh4oVJMA0GCSqGSIb3DQEBDAUA
MIGIMQswCQYDVQQGEwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5
IENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRy
dXN0IFJTQSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0yMDAyMTgwMDAwMDBaFw0zMzA1
MDEyMzU5NTlaMEYxCzAJBgNVBAYTAk5MMRkwFwYDVQQKExBHRUFOVCBWZXJlbmlnaW5nMRww
GgYDVQQDExNHRUFOVCBQZXJzb25hbCBDQSA0MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIIC
CgKCAgEAs0riIl4nW+kEWxQENTIgFK600jFAxs1QwB6hRMqvnkphfy2Q3mKbM2otpELKlgE8
/3AQPYBo7p7yeORuPMnAuA+oMGRb2wbeSaLcZbpwXgfCvnKxmq97/kQkOFX706F9O7/h0yeh
HhDjUdyMyT0zMs4AMBDRrAFn/b2vR3j0BSYgoQs16oSqadM3p+d0vvH/YrRMtOhkvGpLuzL8
m+LTAQWvQJ92NwCyKiHspoP4mLPJvVpEpDMnpDbRUQdftSpZzVKTNORvPrGPRLnJ0EEVCHR8
2LL6oz915WkrgeCY9ImuulBn4uVsd9ZpubCgM/EXvVBlViKqusChSsZEn7juIsGIiDyaIhhL
sd3amm8BS3bgK6AxdSMROND6hiHT182Lmf8C+gRHxQG9McvG35uUvRu8v7bPZiJRaT7ZC2f5
0P4lTlnbLvWpXv5yv7hheO8bMXltiyLweLB+VNvg+GnfL6TW3Aq1yF1yrZAZzR4MbpjTWdEd
SLKvz8+0wCwscQ81nbDOwDt9vyZ+0eJXbRkWZiqScnwAg5/B1NUD4TrYlrI4n6zFp2pyYUOi
uzP+as/AZnz63GvjFK69WODR2W/TK4D7VikEMhg18vhuRf4hxnWZOy0vhfDR/g3aJbdsGac+
diahjEwzyB+UKJOCyzvecG8bZ/u/U8PsEMZg07iIPi8CAwEAAaOCAYswggGHMB8GA1UdIwQY
MBaAFFN5v1qqK0rPVIDh2JvAnfKyA2bLMB0GA1UdDgQWBBRpAKHHIVj44MUbILAK3adRvxPZ
5DAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEF
BQcDAgYIKwYBBQUHAwQwOAYDVR0gBDEwLzAtBgRVHSAAMCUwIwYIKwYBBQUHAgEWF2h0dHBz
Oi8vc2VjdGlnby5jb20vQ1BTMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwudXNlcnRy
dXN0LmNvbS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNybDB2BggrBgEF
BQcBAQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNlcnRydXN0LmNvbS9VU0VSVHJ1
c3RSU0FBZGRUcnVzdENBLmNydDAlBggrBgEFBQcwAYYZaHR0cDovL29jc3AudXNlcnRydXN0
LmNvbTANBgkqhkiG9w0BAQwFAAOCAgEACgVOew2PHxM5AP1v7GLGw+3tF6rjAcx43D9Hl110
Q+BABABglkrPkES/VyMZsfuds8fcDGvGE3o5UfjSno4sij0xdKut8zMazv8/4VMKPCA3EUS0
tDUoL01ugDdqwlyXuYizeXyH2ICAQfXMtS+raz7mf741CZvO50OxMUMxqljeRfVPDJQJNHOY
i2pxuxgjKDYx4hdZ9G2o+oLlHhu5+anMDkE8g0tffjRKn8I1D1BmrDdWR/IdbBOj6870abYv
qys1qYlPotv5N5dm+XxQ8vlrvY7+kfQaAYeO3rP1DM8BGdpEqyFVa+I0rpJPhaZkeWW7cImD
QFerHW9bKzBrCC815a3WrEhNpxh72ZJZNs1HYJ+29NTB6uu4NJjaMxpk+g2puNSm4b9uVjBb
PO9V6sFSG+IBqE9ckX/1XjzJtY8Grqoo4SiRb6zcHhp3mxj3oqWi8SKNohAOKnUc7RIP6ss1
hqIFyv0xXZor4N9tnzD0Fo0JDIURjDPEgo5WTdti/MdGTmKFQNqxyZuT9uSI2Xvhz8p+4pCY
kiZqpahZlHqMFxdw9XRZQgrP+cgtOkWEaiNkRBbvtvLdp7MCL2OsQhQEdEbUvDM9slzZXdI7
NjJokVBq3O4pls3VD2z3L/bHVBe0rBERjyM2C/HSIh84rfmAqBgklzIOqXhd+4RzadUxggM7
MIIDNwIBATBbMEYxCzAJBgNVBAYTAk5MMRkwFwYDVQQKExBHRUFOVCBWZXJlbmlnaW5nMRww
GgYDVQQDExNHRUFOVCBQZXJzb25hbCBDQSA0AhEA4UndIhoJ6GHY0AfIvqwhNzANBglghkgB
ZQMEAgEFAKCCAbEwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcN
MjExMDExMTM0NDE0WjAvBgkqhkiG9w0BCQQxIgQgoEHPhfrJClU7nxw14A8pNg0JsPG4wCxg
m11jhELuig4wagYJKwYBBAGCNxAEMV0wWzBGMQswCQYDVQQGEwJOTDEZMBcGA1UEChMQR0VB
TlQgVmVyZW5pZ2luZzEcMBoGA1UEAxMTR0VBTlQgUGVyc29uYWwgQ0EgNAIRAOFJ3SIaCehh
2NAHyL6sITcwbAYJKoZIhvcNAQkPMV8wXTALBglghkgBZQMEASowCwYJYIZIAWUDBAECMAoG
CCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggq
hkiG9w0DAgIBKDBsBgsqhkiG9w0BCRACCzFdoFswRjELMAkGA1UEBhMCTkwxGTAXBgNVBAoT
EEdFQU5UIFZlcmVuaWdpbmcxHDAaBgNVBAMTE0dFQU5UIFBlcnNvbmFsIENBIDQCEQDhSd0i
GgnoYdjQB8i+rCE3MA0GCSqGSIb3DQEBAQUABIIBAEuExnR7Pp/4b0imaw2SKOAS+UHNPpol
gGV9TrkqilJ3jvo8Ig8OcXGbJ7i+E/fWuyqKi8kiTrZzcchI9eNqDzXQJxUmaKJGx8C85iX2
eXrc66vnbyu01JQgo+ml7P5mWxBqGvFf7uSRSKrGqIdo5Q9JC7+Uuavdy8cZLfHL4KQ5D3qI
hAWkQCKqOU+OeOWn/9xc8if0RXIcpwPFYuEMeijA7iXY1XFLJZhJ0Dzty43rUZTaR/4SrDII
oiCb5hMakjXZta2WAqnRdEsbOX5PT/LlvSsguxVtw9hdPwcK2NwoMkE215PuFaVqG0gdJ1/x
IsfZ/3vKKMVcLIsvnR7fXiYAAAAAAAA=

--------------ms070008010506010506000901--
